function [DataNames] = get_data_from_folder(ParentFolder, keyword)
% input:
% ParentFolder: e.g., '~\formatted_data\SwitchCost_Human'
% keyword: e.g.,'001*.mat' to search for all the data of subject 1

%% 找到所有的子文件夹
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

%% 在所有子文件夹里寻找带keyword的文件
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
% 函数功能为获取父文件夹下所有子文件夹的路径
% 函数的输入为ParentFolder：父文件夹路径。eg: 'D:\Program Files'
% 函数的输出为SubFolders：子文件夹路径。为一个元胞数组，eg: {'D:\Program Files\FileZilla FTP Client'}
%% 提取子文件名称
SubFolderNames = dir(ParentFolder); % 子文件夹名称
for i = 1:length(SubFolderNames)
    if (isequal(SubFolderNames(i).name,'.') || isequal(SubFolderNames(i).name,'..') || ~SubFolderNames(i).isdir)
        continue % 回到if处进入下一次循环
    end
    SubFolder(i).SubFolderName = fullfile(ParentFolder, SubFolderNames(i).name);
end

%% 是否存在subfolder，没有的话就不往下搜索
if exist('SubFolder','var')
    SubFoldersExist = true;
    temp = {SubFolder.SubFolderName};
    idx = cellfun(@(x)~isempty(x),temp,'UniformOutput',true); % 利用cellfun函数得到元胞数组中所有非空元素的下标
    SubFolders = temp(idx);
else
    SubFoldersExist = false;
    SubFolders = NaN;
end
end

function [FilePath] = GetFileNames(path, keyword)
% GetFileNames
% 函数的功能为获得某一路径下，某种格式所有文件名
% 函数的输入1为Path,要获取的路径。eg: 'D:\Program Files\FileZilla FTP Client\docs'
% 函数的输入2为Keyword，要获取文件的关键词。eg: '*.txt','*.docx','*.png'
FilePath = [];
DirOutput = dir(fullfile(path, keyword));
for k = 1:length(DirOutput)
    if DirOutput(k).isdir==0
        FilePath = [FilePath, fullfile(path,{DirOutput(k).name})];
    end
end
end



