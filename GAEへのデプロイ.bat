cd %~dp0

rem  --no-promote���w�肷��ƁA�����ŐV�o�[�W�����ɐ؂�ւ��Ȃ��Ȃ�B�؂�ւ��O�ɓ�����m�F�������ꍇ�ɗ��p�B 
rem  �؂�ւ���ꍇ�́AGCP�|�[�^���́uApp Engine�v���u�o�[�W�����v�őΏۃT�[�r�X��I�сA�u�g���t�B�b�N�𕪊��v�ōŐV�o�[�W�����ւ̃g���t�B�b�N��100%�ɂ���B 

gcloud app deploy --project GCP�̃v���W�F�N�g�� --quiet --no-promote app.yaml

pause
