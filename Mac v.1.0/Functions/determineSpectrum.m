function [kVp,mA,Cu,Al,E0,I0,maxE0,minE0] = determineSpectrum(q,tubeVoltage,tubeCurrent,copperFilter,aluminiumFilter,ax,recButtonState)
            I0 = q;
            %Energies in keV
            E0=1:1:length(I0);

            %Eliminate zero values from vector
            E0=E0(I0~=0);

            %Max/Min value of energy in the spectrum
            maxE0 = max(E0);
            minE0 = min(E0);

            %String which is displayed in text box
            stringforBox1='Min energy: %d keV';
            stringforBox2='Max energy: %d keV';
%             stringforbox3 ='Peak kilovoltage: %d kV';
%             stringforbox4 ='Tube Current: %d kV';
            stringforBox1 = sprintf(stringforBox1,minE0);
            stringforBox2 = sprintf(stringforBox2,maxE0);

            kVp=tubeVoltage;
%             stringforBox3 = sprintf(stringforbox3,kVp);
            mA=tubeCurrent;
%             stringforBox4 = sprintf(stringforbox4,mA);
            Cu=copperFilter;
            Al=aluminiumFilter;

            %Plot spectrum in Spectrum figure
            %             plot(I0,'LineWidth',2, 'Parent',ax);
            plot(I0,'LineWidth',2, 'Parent',ax);

            limY = max(I0);
            ax.YLim = [0 limY];

            %Display min and max energies of the spectrum in text box
            text(ax,70,limY-limY/10,stringforBox1,'Color','w','FontSize',11);
            text(ax,70,limY-2*limY/10,stringforBox2,'Color','w','FontSize',11);
            % text(ax,65,limY-3*limY/10,stringforBox3,'Color','w','FontSize',11);

            ax.XTickMode = 'auto';
            ax.YTickMode = 'auto';
            recButtonState.Enable = 'on';
            
end