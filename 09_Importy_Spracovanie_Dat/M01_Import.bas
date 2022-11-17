Attribute VB_Name = "M01_Import"
Option Explicit

Sub import_dat_znecistenie()
Attribute import_dat_znecistenie.VB_Description = "Nahrat a spracovat data z CSV suboru. "
Attribute import_dat_znecistenie.VB_ProcData.VB_Invoke_Func = "I\n14"
'
' import_dat_znecistenie Makro
' Nahrat a spracovat data z CSV suboru.
'
' Kl�vesov� skratka: Ctrl+Shift+I
'
    ActiveWorkbook.Queries.Add Name:="country_level_data_0", Formula:= _
        "let" & Chr(13) & "" & Chr(10) & "    Zdroj = Csv.Document(File.Contents(""C:\Users\Administrator\Desktop\country_level_data_0.csv""),[Delimiter="","", Columns=49, Encoding=65001, QuoteStyle=QuoteStyle.None])," & Chr(13) & "" & Chr(10) & "    #""Hlavi�ky so zv��enou �rov�ou"" = Table.PromoteHeaders(Zdroj, [PromoteAllScalars=true])," & Chr(13) & "" & Chr(10) & "    #""Nahraden� hodnota"" = Table.ReplaceValue(#""Hlavi�ky so zv��enou �rov�ou"",""."",""" & _
        ","",Replacer.ReplaceText,{""gdp""})," & Chr(13) & "" & Chr(10) & "    #""Zmenen� typ"" = Table.TransformColumnTypes(#""Nahraden� hodnota"",{{""gdp"", type number}})," & Chr(13) & "" & Chr(10) & "    #""Nahraden� chyby"" = Table.ReplaceErrorValues(#""Zmenen� typ"", {{""gdp"", 0}})," & Chr(13) & "" & Chr(10) & "    #""Nahraden� hodnota1"" = Table.ReplaceValue(#""Nahraden� chyby"",""."","","",Replacer.ReplaceText,{""composition_food_organic_waste_perc" & _
        "ent"", ""composition_glass_percent"", ""composition_metal_percent"", ""composition_other_percent"", ""composition_paper_cardboard_percent"", ""composition_plastic_percent""})," & Chr(13) & "" & Chr(10) & "    #""Zmenen� typ1"" = Table.TransformColumnTypes(#""Nahraden� hodnota1"",{{""composition_food_organic_waste_percent"", type number}, {""composition_glass_percent"", type number}, {""composi" & _
        "tion_metal_percent"", type number}, {""composition_other_percent"", type number}, {""composition_paper_cardboard_percent"", type number}, {""composition_plastic_percent"", type number}})," & Chr(13) & "" & Chr(10) & "    #""Nahraden� chyby1"" = Table.ReplaceErrorValues(#""Zmenen� typ1"", {{""composition_food_organic_waste_percent"", 0}, {""composition_glass_percent"", 0}, {""composition_metal_" & _
        "percent"", 0}, {""composition_other_percent"", 0}, {""composition_paper_cardboard_percent"", 0}, {""composition_plastic_percent"", 0}})," & Chr(13) & "" & Chr(10) & "    #""Odstr�nen� st�pce"" = Table.RemoveColumns(#""Nahraden� chyby1"",{""waste_collection_coverage_urban_percent_of_geographic_area"", ""waste_collection_coverage_urban_percent_of_households""})" & Chr(13) & "" & Chr(10) & "in" & Chr(13) & "" & Chr(10) & "    #""Odstr�nen� st�pce"""
    ActiveWorkbook.Worksheets.Add
    With ActiveSheet.ListObjects.Add(SourceType:=0, Source:= _
        "OLEDB;Provider=Microsoft.Mashup.OleDb.1;Data Source=$Workbook$;Location=country_level_data_0;Extended Properties=""""" _
        , Destination:=Range("$A$1")).QueryTable
        .CommandType = xlCmdSql
        .CommandText = Array("SELECT * FROM [country_level_data_0]")
        .RowNumbers = False
        .FillAdjacentFormulas = False
        .PreserveFormatting = True
        .RefreshOnFileOpen = False
        .BackgroundQuery = True
        .RefreshStyle = xlInsertDeleteCells
        .SavePassword = False
        .SaveData = True
        .AdjustColumnWidth = True
        .RefreshPeriod = 0
        .PreserveColumnInfo = True
        .ListObject.DisplayName = "country_level_data_0"
        .Refresh BackgroundQuery:=False
    End With
    ActiveSheet.ListObjects("country_level_data_0").TableStyle = _
        "TableStyleMedium8"
    Range("country_level_data_0[[#Headers],[region_id]]").Select
End Sub
