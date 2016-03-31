function w = srnpak(srn_net)

w = [srn_net.w1_in(:);srn_net.w1_rec(:);srn_net.b1(:);srn_net.w2(:);srn_net.b2(:)];