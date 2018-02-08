fprintf('* Maximum harmonic order : %d / %.3f MHz \n',har_pow_max_order, fh(har_pow_max_order)*fint);
% fprintf('* Encode: %.3f MHz\n',fclk/1e6);
% fprintf('* Analog: %.3f MHz\n',fbase*fint);
fprintf('* Fund:  %6.3f  dBFS          Windowing:  Hanning\n',Fund_1);
fprintf('* Fund:  %6.3f  dBFS          Windowing:  Bh4\n',Fund_2);
% SNR
if SNR_1>SNR_2
    fprintf('* SNR:  %7.2f  dB  ',SNR_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* SNR:  %7.2f  dB  ',SNR_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% SINAD
if SINAD_1>SINAD_2
    fprintf('* SINAD:%7.2f  dB  ',SINAD_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* SINAD:%7.2f  dB  ',SINAD_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% ENOB
if ENOB_1>ENOB_2
    fprintf('* ENOB: %7.2f  Bits',ENOB_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* ENOB: %7.2f  Bits',ENOB_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% SFDR
if SFDR_1>SFDR_2
    fprintf('* SFDR: %7.2f  dBc ',SFDR_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* SFDR: %7.2f  dBc ',SFDR_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % SNRFS
% if SNRFS_1>SNRFS_2
%     fprintf('* SNRFS:%7.2f  dB  ',SNRFS_1);
%     if (COHER_SAMP1==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP1==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% else
%     fprintf('* SNRFS:%7.2f  dB  ',SNRFS_2);
%     if (COHER_SAMP2==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP2==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% end
% 2nd
if H_2nd_1<H_2nd_2
    fprintf('* 2nd:  %7.2f  dBc ',H_2nd_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* 2nd:  %7.2f  dBc ',H_2nd_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% 3rd
if H_3rd_1<H_3rd_2
    fprintf('* 3rd:  %7.2f  dBc ',H_3rd_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* 3rd:  %7.2f  dBc ',H_3rd_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% 4th
if H_4th_1<H_4th_2
    fprintf('* 4th:  %7.2f  dBc ',H_4th_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* 4th:  %7.2f  dBc ',H_4th_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% 5th
if H_5th_1<H_5th_2
    fprintf('* 5th:  %7.2f  dBc ',H_5th_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* 5th:  %7.2f  dBc ',H_5th_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% 6th
if H_6th_1<H_6th_2
    fprintf('* 6th:  %7.2f  dBc ',H_6th_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* 6th:  %7.2f  dBc ',H_6th_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% THD
if THD_1<THD_2
    fprintf('* THD:  %7.2f  dBc ',THD_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* THD:  %7.2f  dBc ',THD_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% H23
if H23_1<H23_2
    fprintf('* Worst 2nd or 3rd Harmonic: %.2f  dBc ',H23_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* Worst 2nd or 3rd Harmonic: %.2f  dBc ',H23_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% H456
if H456_1<H456_2
    fprintf('* Worst 4th or 5th or 6th Harmonic: %.2f  dBc ',H456_1);
    if (COHER_SAMP1==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
else
    fprintf('* Worst 4th or 5th or 6th Harmonic: %.2f  dBc ',H456_2);
    if (COHER_SAMP2==0)
    fprintf('          Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('          Windowing:  Bh4\n');
        else
            fprintf('          Windowing:  None\n');
        end
    end
end
% Noise Floor
if NoiseFloor_1<NoiseFloor_2
    fprintf('* Noise Floor: %.2f dBFS',NoiseFloor_1);
    if (COHER_SAMP1==0)
    fprintf('    Windowing:  Hanning\n');
    else if (COHER_SAMP1==1)
        fprintf('    Windowing:  Bh4\n');
        else
            fprintf('    Windowing:  None\n');
        end
    end
else
    fprintf('* Noise Floor: %.2f dBFS',NoiseFloor_2);
    if (COHER_SAMP2==0)
    fprintf('    Windowing:  Hanning\n');
    else if (COHER_SAMP2==1)
        fprintf('    Windowing:  Bh4\n');
        else
            fprintf('    Windowing:  None\n');
        end
    end
end


% fprintf('* Samples:  %d \n',dPnts);
if (COHER_SAMP==0)
    fprintf('* Windowing:  Hanning\n');
    else if (COHER_SAMP==1)
        fprintf('* Windowing:  Bh4\n');
        else
            fprintf('* Windowing:  None\n');
        end
end


% % 7th
% if H_7th_1<H_7th_2
%     fprintf('* 7th:  %7.2f  dBc ',H_7th_1);
%     if (COHER_SAMP1==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP1==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% else
%     fprintf('* 7th:  %7.2f  dBc ',H_7th_2);
%     if (COHER_SAMP2==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP2==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% end
% % 8th
% if H_8th_1<H_8th_2
%     fprintf('* 8th:  %7.2f  dBc ',H_8th_1);
%     if (COHER_SAMP1==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP1==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% else
%     fprintf('* 8th:  %7.2f  dBc ',H_8th_2);
%     if (COHER_SAMP2==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP2==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% end
% % 9th
% if H_9th_1<H_9th_2
%     fprintf('* 9th:  %7.2f  dBc ',H_9th_1);
%     if (COHER_SAMP1==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP1==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% else
%     fprintf('* 9th:  %7.2f  dBc ',H_9th_2);
%     if (COHER_SAMP2==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP2==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% end
% % 9th
% if H_9th_1<H_9th_2
%     fprintf('* 9th:  %7.2f  dBc ',H_9th_1);
%     if (COHER_SAMP1==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP1==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% else
%     fprintf('* 9th:  %7.2f  dBc ',H_9th_2);
%     if (COHER_SAMP2==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP2==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% end
% % 10th
% if H_10th_1<H_10th_2
%     fprintf('* 10th: %7.2f  dBc ',H_10th_1);
%     if (COHER_SAMP1==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP1==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% else
%     fprintf('* 10th: %7.2f  dBc ',H_10th_2);
%     if (COHER_SAMP2==0)
%     fprintf('          Windowing:  Hanning\n');
%     else if (COHER_SAMP2==1)
%         fprintf('          Windowing:  Bh4\n');
%         else
%             fprintf('          Windowing:  None\n');
%         end
%     end
% end
% 
