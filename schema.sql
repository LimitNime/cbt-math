-- 1. DROP EXISTING (WARNING: ALL DATA WILL BE RESET)
DROP TABLE IF EXISTS public.student_data;
DROP TABLE IF EXISTS public.profiles;
DROP TABLE IF EXISTS public.app_settings;
DROP TABLE IF EXISTS public.admin_accounts;
DROP TABLE IF EXISTS public.cbt_stages;
DROP TABLE IF EXISTS public.questions_library;
DROP TABLE IF EXISTS public.math_exercises;

-- 2. PROFILES TABLE (AUTHENTICATION)
CREATE TABLE public.profiles (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    nama TEXT NOT NULL,
    kelas TEXT NOT NULL,
    sekolah TEXT NOT NULL,
    gender TEXT,
    dob DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. STUDENT DATA & PROGRESS
CREATE TABLE public.student_data (
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE PRIMARY KEY,
    current_meeting INT DEFAULT 1, -- Controls which meeting the student is ON
    current_stage INT DEFAULT 0,   -- 0 (Pretest), 1-5 (CBT Stages), 6 (Posttest), 7 (Media Response)
    
    -- Status Flags
    pretest_done BOOLEAN DEFAULT FALSE,
    cbt_stage_1_done BOOLEAN DEFAULT FALSE,
    cbt_stage_2_done BOOLEAN DEFAULT FALSE,
    cbt_stage_3_done BOOLEAN DEFAULT FALSE,
    cbt_stage_4_done BOOLEAN DEFAULT FALSE,
    cbt_stage_5_done BOOLEAN DEFAULT FALSE,
    posttest_done BOOLEAN DEFAULT FALSE,
    respon_media_done BOOLEAN DEFAULT FALSE,

    -- Telemetry Data
    skor_pre_kecemasan INT,
    skor_post_kecemasan INT,
    skor_pre_motivasi INT,
    skor_post_motivasi INT,
    emosi_awal TEXT,
    emosi_akhir TEXT,
    skor_kuis INT,
    detil_dimensi JSONB,
    jawaban_pre JSONB,
    jawaban_post JSONB,
    pikiran_dipilih JSONB,
    afirmasi_dipilih TEXT,
    jawaban_respon_media JSONB, -- NEW: For the final media evaluation
    
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 4. GLOBAL SETTINGS (TEACHER CONTROL)
CREATE TABLE public.app_settings (
    key TEXT PRIMARY KEY,
    value JSONB -- Changed to JSONB for flexibility
);

-- 5. ADMIN ACCOUNTS
CREATE TABLE public.admin_accounts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 6. CONTENT: CBT STAGES
CREATE TABLE public.cbt_stages (
    stage_number INT PRIMARY KEY,
    title TEXT NOT NULL,
    subtitle TEXT,
    description TEXT,
    content_json JSONB, -- For specific stage data like reframe tables, etc.
    is_active BOOLEAN DEFAULT TRUE
);

-- 7. CONTENT: QUESTIONNAIRES (Anxiety, Motivation, Media)
CREATE TABLE public.questions_library (
    id TEXT PRIMARY KEY, -- e.g. 'k1', 'm1', 'r1'
    type TEXT NOT NULL, -- 'anxiety', 'motivation', 'media_response'
    text TEXT NOT NULL,
    dimensi TEXT,
    is_positive BOOLEAN DEFAULT TRUE,
    order_index INT
);

-- 8. CONTENT: MATH EXERCISES
CREATE TABLE public.math_exercises (
    id SERIAL PRIMARY KEY,
    question_text TEXT NOT NULL,
    hint TEXT,
    options JSONB NOT NULL, -- Array of strings
    correct_answer_index INT NOT NULL,
    explanation TEXT,
    category TEXT -- e.g. 'SPLSV', 'SPLDV'
);

-- 9. SECURITY (RLS)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.app_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admin_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cbt_stages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions_library ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.math_exercises ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Public Profiles Access" ON public.profiles FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Student Data Access" ON public.student_data FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Settings Access" ON public.app_settings FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Admin Access" ON public.admin_accounts FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Public Stages Access" ON public.cbt_stages FOR SELECT USING (true);
CREATE POLICY "Public Questions Access" ON public.questions_library FOR SELECT USING (true);
CREATE POLICY "Public Math Access" ON public.math_exercises FOR SELECT USING (true);

-- Admin Modify Permissions (Simplified for researcher setup)
CREATE POLICY "Admin Modify Stages" ON public.cbt_stages FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Admin Modify Questions" ON public.questions_library FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Admin Modify Math" ON public.math_exercises FOR ALL USING (true) WITH CHECK (true);

-- INITIAL SETTINGS
INSERT INTO public.app_settings (key, value) VALUES ('pertemuan_aktif', '"1"');
INSERT INTO public.app_settings (key, value) VALUES ('site_config', '{"title": "MathEase CBT", "description": "Platform Terapi Matematika"}');

-- INITIAL ADMIN (Username: admin, Password: admin123 - USER SHOULD CHANGE THIS)
INSERT INTO public.admin_accounts (username, password) VALUES ('admin', 'admin123');
