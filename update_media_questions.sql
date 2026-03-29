-- ══════════════════════════════════════════════════════════════
-- GANTI SEMUA PERTANYAAN RESPON MEDIA
-- Jalankan di Supabase SQL Editor
-- ══════════════════════════════════════════════════════════════

-- Step 1: Hapus semua pertanyaan respon media yang lama
DELETE FROM public.questions_library WHERE type = 'media_response';

-- Step 2: Masukkan 30 pertanyaan baru
INSERT INTO public.questions_library (id, type, text, dimensi, is_positive, order_index) VALUES
('r1',  'media_response', 'Tampilan media terlihat menarik dan membuat saya ingin menggunakannya',             'Tampilan',                  true,  1),
('r2',  'media_response', 'Tampilan media membuat saya nyaman saat belajar matematika',                        'Tampilan',                  true,  2),
('r3',  'media_response', 'Tampilan media terasa membosankan saat digunakan',                                  'Tampilan',                  false, 3),
('r4',  'media_response', 'Tampilan media membantu saya memahami alur kegiatan pembelajaran',                  'Tampilan',                  true,  4),
('r5',  'media_response', 'Warna pada media mendukung kenyamanan saat membaca materi',                         'Tampilan',                  true,  5),
('r6',  'media_response', 'Media mudah digunakan dalam kegiatan pembelajaran',                                 'Kemudahan',                 true,  6),
('r7',  'media_response', 'Petunjuk dalam media membantu saya mengikuti setiap langkah',                      'Kemudahan',                 true,  7),
('r8',  'media_response', 'Penggunaan media terasa menyulitkan saat belajar',                                  'Kemudahan',                 false, 8),
('r9',  'media_response', 'Saya dapat mengikuti tahapan dalam media dengan baik',                              'Kemudahan',                 true,  9),
('r10', 'media_response', 'Menu dalam media memudahkan saya berpindah antar bagian',                           'Kemudahan',                 true,  10),
('r11', 'media_response', 'Media membantu saya memahami perasaan saat belajar matematika',                     'Isi/CBT',                   true,  11),
('r12', 'media_response', 'Media membantu saya mengenali pikiran saat belajar matematika',                     'Isi/CBT',                   true,  12),
('r13', 'media_response', 'Isi dalam media terasa membingungkan saat digunakan',                               'Isi/CBT',                   false, 13),
('r14', 'media_response', 'Media membantu saya melihat cara berpikir yang lebih positif',                      'Isi/CBT',                   true,  14),
('r15', 'media_response', 'Kegiatan dalam media tersusun jelas dan mudah diikuti',                             'Isi/CBT',                   true,  15),
('r16', 'media_response', 'Media membantu saya merasa lebih tenang saat belajar matematika',                   'Manfaat (Kecemasan)',        true,  16),
('r17', 'media_response', 'Media membantu saya mengurangi rasa takut saat menghadapi soal matematika',         'Manfaat (Kecemasan)',        true,  17),
('r18', 'media_response', 'Saya masih merasa cemas saat belajar matematika setelah menggunakan media',         'Manfaat (Kecemasan)',        false, 18),
('r19', 'media_response', 'Media membuat saya lebih siap saat mengerjakan soal matematika',                    'Manfaat (Kecemasan)',        true,  19),
('r20', 'media_response', 'Saya merasa tegang saat belajar matematika meskipun sudah menggunakan media',       'Manfaat (Kecemasan)',        false, 20),
('r21', 'media_response', 'Media membuat saya lebih tertarik belajar matematika',                              'Manfaat (Motivasi Intrinsik)', true,  21),
('r22', 'media_response', 'Saya memiliki keinginan untuk memahami materi matematika setelah menggunakan media','Manfaat (Motivasi Intrinsik)', true,  22),
('r23', 'media_response', 'Saya merasa belajar matematika hanya sebagai kewajiban setelah menggunakan media',  'Manfaat (Motivasi Intrinsik)', false, 23),
('r24', 'media_response', 'Saya merasa lebih senang saat belajar matematika menggunakan media',                'Manfaat (Motivasi Intrinsik)', true,  24),
('r25', 'media_response', 'Saya merasa kurang tertarik untuk mengeksplorasi materi matematika lebih lanjut',   'Manfaat (Motivasi Intrinsik)', false, 25),
('r26', 'media_response', 'Saya terlibat aktif saat menggunakan media dalam pembelajaran',                     'Keterlibatan',              true,  26),
('r27', 'media_response', 'Media membuat saya tertarik mengikuti kegiatan pembelajaran',                       'Keterlibatan',              true,  27),
('r28', 'media_response', 'Saya merasa kurang tertarik saat mengikuti pembelajaran dengan media',               'Keterlibatan',              false, 28),
('r29', 'media_response', 'Saya menikmati belajar matematika menggunakan media',                               'Keterlibatan',              true,  29),
('r30', 'media_response', 'Media membantu saya lebih fokus saat mengikuti pembelajaran',                       'Keterlibatan',              true,  30);

-- Verifikasi
SELECT id, dimensi, is_positive, order_index, text FROM public.questions_library
WHERE type = 'media_response'
ORDER BY order_index;
