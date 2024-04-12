function EmiPMs = ipOpa(workbookFile, sheetName, dataLines)
%IMPORTFILE1 Import data from a spreadsheet
%  EMIPMS = IMPORTFILE1(FILE) reads data from the first worksheet in the
%  Microsoft Excel spreadsheet file named FILE.  Returns the data as a
%  table.
%
%  EMIPMS = IMPORTFILE1(FILE, SHEET) reads from the specified worksheet.
%
%  EMIPMS = ipOpa(FILE, SHEET, DATALINES) reads from the specified
%  worksheet for the specified row interval(s). Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  EmiPMs = ipOpa("/Users/penquin/Library/CloudStorage/OneDrive-KMITL/Project/EmiPMs.xlsx", "Opacity", [3, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 27-Oct-2023 23:29:56

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [3, Inf];
end

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 11);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = dataLines(1, :);

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Condition1", "VarName7", "B7", "B7CeO2_300DOCPt_300PDPF", "B10", "B100"];
opts.SelectedVariableNames = ["Condition1", "VarName7", "B7", "B7CeO2_300DOCPt_300PDPF", "B10", "B100"];
opts.VariableTypes = ["char", "char", "char", "char", "char", "double", "double", "double", "string", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "B7CeO2_300DOCPt_300PDPF"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "B7CeO2_300DOCPt_300PDPF"], "EmptyFieldRule", "auto");

% Import the data
EmiPMs = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = dataLines(idx, :);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    EmiPMs = [EmiPMs; tb]; %#ok<AGROW>
end

end