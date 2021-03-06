program opendss;

{$mode delphi}{$H+}
//{$apptype console}
uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,sysutils, Ucmatrix, Arraydef, Command, HashList, LineUnits, Mathutil,
  PointerList, Pstcalc, StackDef, Dynamics, RPN, ParserDel, Conductor,
  DSSGlobals, Terminal, NamedObject, Bus, pdelement, cktelementclass,
  dssclassdefs, line, transformer, vsource, utilities, dssobject, monitor,
  MeterClass, meterelement, Feeder, load, generator, solutionalgs, ymatrix,
  capcontrol, CapControlVars, ControlClass, ControlElem, GenDispatcher,
  RegControl, ExecCommands, ExecHelper, ExecOptions, Executive, ShowOptions,
  ShowResults, CableConstants, CableData, CNData, CNLineConstants,
  ConductorData, GrowthShape, LineCode, LineConstants, LineGeometry, LoadShape,
  OHLineConstants, PriceShape, Spectrum, TSData, TempShape, TSLineConstants,
  WireData, XfmrCode, Equivalent, Isource, PCClass, PCElement, Capacitor, Fault,
  Fuse, PDClass, Reactor, GeneratorVars, Sensor, LineSpacing, ReduceAlgs;
var

//r:real;

//s1,s2,s3,s4:string;
s1:string;
  str : string;

    InBlockComment : Boolean;

    cmdList: TStringList;

           imax,i:integer;

           inputfile:textfile;

           ParamStr:string;


begin
    //printhello;
    //PrintHelloS(12);
//  writeln('hello!');
  writeln('hello!');
  try
  InBlockComment := False;

  cmdList := TStringList.Create;

  cmdList.Clear;

  ExtractFilePath(ParamStr);

  DSSExecutive:=Texecutive.Create;

    if FileExists('/home/ju/Dropbox/yuntao_whole_life/opendss/1.txt') then

    begin
    assignfile(inputfile,'/home/ju/Dropbox/yuntao_whole_life/opendss/1.txt');
    reset(inputfile);
    repeat
    readln(inputfile,s1);
    str:=Trim(s1);
    if Length(str) > 0 then
      Begin
         if Not InBlockComment then     // look for '/*'  at baginning of line
            case str[1] of
               '/': if (Length(str) > 1) and (str[2]='*')then
                    InBlockComment := TRUE;
            end;
            If Not InBlockComment Then cmdList.Add (str);
        // in block comment ... look for */   and cancel block comment (whole line)
        if InBlockComment then
          if Pos('*/', str)>0 then  InBlockComment := FALSE;
      End;
      {
        NOTE:  InBlockComment resets to FALSE upon leaving this routine
        So if you fail to select a line containing the end of the block comment,
        the next selection will not be blocked.
      }
    until eof(inputfile);
     closefile(inputfile);
       imax := cmdList.Count - 1;
       for i := 0 to imax do begin
           DSSExecutive.Command := cmdList.Strings[i];
       end;
          end;
     cmdList.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.








end.

