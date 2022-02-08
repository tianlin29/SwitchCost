function [DataNames] = get_data_from_folder(ParentFolder, keyword)
% input:
% ParentFolder: e.g., '~\formatted_data\SwitchCost_Human'
% keyword: e.g.,'001*.mat' to search for all the data of subject 1

%% �ҵ����е����ļ���
allsub = [];
count = 0;
SubFoldersExist = true;
while SubFoldersExist == true
    if exist('SubFolders','var')
        ParentFolderList = allsub(end-count+1:end);
        count = 0;
        for i = 1:length(ParentFolderList)
            ParentFolder = ParentFolderList{i};
            [SubFolders, SubFoldersExist] = GetFolders(ParentFolder);
            allsub = [allsub, SubFolders];
            count = count+length(SubFolders);
        end
    else
        [SubFolders, SubFoldersExist] = GetFolders(ParentFolder);
        allsub = [allsub, SubFolders];
        count = length(SubFolders);
    end
end

%% ���������ļ�����Ѱ�Ҵ�keyword���ļ�
allpath = [];
for i = 1:length(allsub)
    if ~isnan(allsub{i})
        path = allsub{i};
        [FilePath] = GetFileNames(path, keyword);
        allpath = [allpath, FilePath];
    end
end
DataNames = allpath';
end



function [SubFolders, SubFoldersExist] = GetFolders(ParentFolder)
% GetFolders
% ��������Ϊ��ȡ���ļ������������ļ��е�·��
% ����������ΪParentFolder�����ļ���·����eg: 'D:\Program Files'
% ���������ΪSubFolders�����ļ���·����Ϊһ��Ԫ�����飬eg: {'D:\Program Files\FileZilla FTP Client'}
%% ��ȡ���ļ�����
SubFolderNames = dir(ParentFolder); % ���ļ�������
for i = 1:length(SubFolderNames)
    if (isequal(SubFolderNames(i).name,'.') || isequal(SubFolderNames(i).name,'..') || ~SubFolderNames(i).isdir)
        continue % �ص�if��������һ��ѭ��
    end
    SubFolder(i).SubFolderName = fullfile(ParentFolder, SubFolderNames(i).name);
end

%% �Ƿ����subfolder��û�еĻ��Ͳ���������
if exist('SubFolder','var')
    SubFoldersExist = true;
    temp = {SubFolder.SubFolderName};
    idx = cellfun(@(x)~isempty(x),temp,'UniformOutput',true); % ����cellfun�����õ�Ԫ�����������зǿ�Ԫ�ص��±�
    SubFolders = temp(idx);
else
    SubFoldersExist = false;
    SubFolders = NaN;
end
end

function [FilePath] = GetFileNames(path, keyword)
% GetFileNames
% �����Ĺ���Ϊ���ĳһ·���£�ĳ�ָ�ʽ�����ļ���
% ����������1ΪPath,Ҫ��ȡ��·����eg: 'D:\Program Files\FileZilla FTP Client\docs'
% ����������2ΪKeyword��Ҫ��ȡ�ļ��Ĺؼ��ʡ�eg: '*.txt','*.docx','*.png'
FilePath = [];
DirOutput = dir(fullfile(path, keyword));
for k = 1:length(DirOutput)
    if DirOutput(k).isdir==0
        FilePath = [FilePath, fullfile(path,{DirOutput(k).name})];
    end
end
end



