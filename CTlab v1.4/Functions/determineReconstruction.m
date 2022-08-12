function reco=determineReconstruction(reconstruction,i,ParametersinfoListBox,BeamgeometryButton)
            reco=reconstruction;
            t = datetime('Now')
            t=datestr(t)
            ParametersinfoListBox.Items(i) = {strcat(t, ' <Reconstruction algorithm: ',reco,'>')}
            BeamgeometryButton.Enable ='on'
end