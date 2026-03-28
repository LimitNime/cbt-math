-- 1. HAPUS TABEL LAMA (PENTING: Pastikan Anda rela menghapus data uji coba yang lama)
DROP TABLE IF EXISTS public.cbt_results;

-- 2. BUAT TABEL BARU DENGAN KOLOM TAMBAHAN
CREATE TABLE public.cbt_results (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    nama TEXT NOT NULL,
    kelas TEXT NOT NULL,
    sekolah TEXT NOT NULL,
    skor_pre_kecemasan INT NOT NULL,
    skor_post_kecemasan INT NOT NULL,
    skor_pre_motivasi INT NOT NULL,
    skor_post_motivasi INT NOT NULL,
    emosi_awal TEXT,
    emosi_akhir TEXT,
    skor_kuis INT,
    detil_dimensi JSONB,
    jawaban_pre JSONB,        -- Menyimpan semua jawaban angket awal (SS/S/TS/STS)
    jawaban_post JSONB,       -- Menyimpan semua jawaban angket akhir (SS/S/TS/STS)
    pikiran_dipilih JSONB,    -- Menyimpan teks pikiran negatif yang dipilih di tahap 2
    afirmasi_dipilih TEXT     -- Menyimpan kalimat afirmasi yang dipilih di tahap 3
);

-- Mengaktifkan Row Level Security (RLS) pada tabel (wajib di Supabase)
ALTER TABLE public.cbt_results ENABLE ROW LEVEL SECURITY;

-- Membuat kebijakan anonim agar semua pengguna (siswa) bisa menyimpan hasil tes (INSERT)
CREATE POLICY "Anon can insert cbt_results" 
    ON public.cbt_results 
    FOR INSERT 
    WITH CHECK (true);

-- Membuat kebijakan anonim agar Anda bisa melihat data (SELECT) di halaman Admin Dashboard
CREATE POLICY "Anon can select cbt_results" 
    ON public.cbt_results 
    FOR SELECT 
    USING (true);

-- Membuat kebijakan anonim agar Anda bisa menghapus data (DELETE) dari Admin Dashboard
CREATE POLICY "Anon can delete cbt_results" 
    ON public.cbt_results 
    FOR DELETE
    USING (true);
