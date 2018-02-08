%%%%%%%%%%%%%%%%%%%%
COHER_SAMP = 0;     % 0 represent hanning window, 1 represent Blackman Harris 4-Term window, 2 represent not using window
COHER_SAMP1=COHER_SAMP;
dynproc_zhuk
Fund_1       =   Fund         ;
SNR_1        =   SNR          ;
SNRFS_1      =   SNRFS        ;
SINAD_1      =   SINAD        ;
ENOB_1       =   ENOB         ;
SFDR_1       =   SFDR         ;
THD_1        =   THD          ;
NoiseFloor_1 =   NoiseFloor   ;
H_2nd_1      =   H_2nd        ;
H_3rd_1      =   H_3rd        ;
H_4th_1      =   H_4th        ;
H_5th_1      =   H_5th        ;
H_6th_1      =   H_6th        ;
H_7th_1      =   H_7th        ;
H_8th_1      =   H_8th        ;
H_9th_1      =   H_9th        ;
H_10th_1     =   H_10th       ;
H23_1        =   max(H_2nd,H_3rd);
H456_1       =   max(H_6th,max(H_4th,H_5th));

COHER_SAMP = 1;     % 0 represent hanning window, 1 represent Blackman Harris 4-Term window, 2 represent not using window
COHER_SAMP2=COHER_SAMP;
if (COHER_SAMP2==COHER_SAMP1)
Fund_2       =   Fund         ;
SNR_2        =   SNR          ;
SNRFS_2      =   SNRFS        ;
SINAD_2      =   SINAD        ;
ENOB_2       =   ENOB         ;
SFDR_2       =   SFDR         ;
THD_2        =   THD          ;
NoiseFloor_2 =   NoiseFloor   ;
H_2nd_2      =   H_2nd        ;
H_3rd_2      =   H_3rd        ;
H_4th_2      =   H_4th        ;
H_5th_2      =   H_5th        ;
H_6th_2      =   H_6th        ;
H_7th_2      =   H_7th        ;
H_8th_2      =   H_8th        ;
H_9th_2      =   H_9th        ;
H_10th_2     =   H_10th       ;
H23_2        =   max(H_2nd,H_3rd);
H456_2       =   max(H_6th,max(H_4th,H_5th));
else
dynproc_zhuk
Fund_2       =   Fund         ;
SNR_2        =   SNR          ;
SNRFS_2      =   SNRFS        ;
SINAD_2      =   SINAD        ;
ENOB_2       =   ENOB         ;
SFDR_2       =   SFDR         ;
THD_2        =   THD          ;
NoiseFloor_2 =   NoiseFloor   ;
H_2nd_2      =   H_2nd        ;
H_3rd_2      =   H_3rd        ;
H_4th_2      =   H_4th        ;
H_5th_2      =   H_5th        ;
H_6th_2      =   H_6th        ;
H_7th_2      =   H_7th        ;
H_8th_2      =   H_8th        ;
H_9th_2      =   H_9th        ;
H_10th_2     =   H_10th       ;
H23_2        =   max(H_2nd,H_3rd);
H456_2       =   max(H_6th,max(H_4th,H_5th));
end
adcdynfprint