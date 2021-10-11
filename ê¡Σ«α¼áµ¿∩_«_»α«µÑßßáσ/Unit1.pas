Unit Unit1;

{$R So1.res}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  ExtCtrls, StdCtrls, Controls, ComCtrls, mmsystem, Tlhelp32, CommCtrl;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Timer1: TTimer;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    TreeView1: TTreeView;
    Shape1: TShape;
    Label4: TLabel;
    Timer2: TTimer;
    Button1: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sys_Windows_Tree(Node: TTreeNode; AHandle: HWND);
    procedure Timer2Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
  private
    procedure ShowHwndAndClassName(CrPos: TPoint);
    procedure WWMove(var Msg: TWMMove);
    message wm_MOVE;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tim: integer;
  WindowName: Integer;
  ProcessId: Integer;
  
implementation

uses Unit2;

{$R *.dfm}

// меняем шрифт строки
procedure SetNodeBoldState(Node: TTreeNode; Value: Boolean);
var
  TVItem: TTVItem;
begin
  if not Assigned(Node) then Exit;
  with TVItem do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    hItem := Node.ItemId;
    stateMask := TVIS_BOLD;
    if Value then state := TVIS_BOLD
    else
      state := 0;
    TreeView_SetItem(Node.Handle, TVItem);
  end;
end;

// осуществляем поиск текста
procedure TSpisok_RabQuickSearch( Tree: TTreeView; SearchTarget: string );
var
  Noddy: TTreeNode;
  Searching: boolean;
  TrText,TrText1,a:string;
  i:integer;
  State:TColor;
begin
   Noddy := Tree.Items[0];
   Searching := true;
   i:=0;
   while ( Searching ) and ( Noddy <> nil ) do
   begin
     TrText:= Form1.TreeView1.Items.Item[i].Text;
     TrText1:= Copy(TrText,Pos('*[',TrText)+2,10);
     a:= Copy(TrText1,1,Pos(']**',TrText1)-1);
      if a = SearchTarget then // если текст найден
      begin
         MessageBeep(MB_ICONEXCLAMATION);
         Form1.Timer2.Enabled:= True;
         Searching := false;
         Tree.Selected := Noddy;
         Tree.SetFocus;
         Form1.Shape1.Brush.Color:= 65956;
         SetNodeBoldState( Tree.Selected , True);
      end
      else
      begin
         Noddy := Noddy.GetNext;
         Form1.Shape1.Brush.Color:= 65956;
      end;
         i:= i+1;
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  StartHandle : THandle;
begin
TreeView1.Items.Clear;
 StartHandle := GetDeskTopWindow; //получаем дескриптор рабочего стола
 Sys_Windows_Tree(nil, StartHandle); // запускаем построение TreeView
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  StartHandle : THandle;
begin
 Timer2.Enabled:= False;
 StartHandle := GetDeskTopWindow; //получаем дескриптор рабочего стола
 Sys_Windows_Tree(nil, StartHandle); // запускаем построение TreeView
end;

procedure TForm1.ShowHwndAndClassName(CrPos: TPoint);
 var
  hWnd: THandle;
  aName: array [0..255] of Char;
  rName: array [0..255] of Char;

begin
  hWnd := WindowFromPoint(CrPos); // получить дескриптор
  Edit1.Text := IntToStr(hWnd);
  GetClassName(hWnd, aName, 255);  // получить имя класса
  GetWindowText(hWnd,rName,255);  // получить название
  Edit2.Text:= string(aName) ;
  Edit3.Text:= string(rName) ;
end;

procedure TForm1.Sys_Windows_Tree(Node: TTreeNode; AHandle: HWND);
const
  MAX = 255;
var
  szClassName, szCaption: array[0..MAX - 1] of Char;
  Result,dop, min: String;
begin
   //Запускаем цикл пока не закончатся окна
  while AHandle <> 0 do
  begin
    //Получаем имя класса окна
    GetClassName(AHandle, szClassName, MAX);
    //Получаем текст  окна
    GetWindowText(AHandle, szCaption, MAX);
    // является окно допустимым?
  if IsWindow(AHandle) then  dop:= 'Допустимое окно'
   else dop:= 'Не допустимое окно';
  if IsIconic(AHandle) then  min:= 'Скрыто'
   else min:= 'Не скрыто';
    Result := '['+String(szClassName)+']  ['+  String(szCaption)+
    ']  ('+dop+')  ('+min+')  *['+IntToStr(AHandle)+']**' ;
    //В следующей процедуре, в скобках, добавляем результат
    //в дерево, получаем хэндл дочернего окна и с результатами
    //выполнения этих двух функций выполняем процедуру Sys_Windows_Tree
    Sys_Windows_Tree(TreeView1.Items.AddChild(Node, Result),
      GetWindow(AHandle, GW_CHILD));
    //Получаем хэндл следующего (не дочернего) окна
    AHandle := GetNextWindow(AHandle, GW_HWNDNEXT);
    //Handle := 0;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  rPos: TPoint;
begin
// получить координаты курсора и передать функции  ShowHwndAndClassName
  if Boolean(GetCursorPos(rPos)) then ShowHwndAndClassName(rPos);
// если нажата <I> запомнить хэндл в Edit5.Text
  if getasynckeystate($49)<>0
  then
  begin
  Edit5.Text:= Edit1.Text;
  sleep(5);
  TSpisok_RabQuickSearch( Form1.TreeView1, Edit5.Text); // запускаем поиск
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  PlaySound('so1', 0, SND_RESOURCE or SND_ASYNC);
  Form1.Shape1.Brush.Color:= 66047;
  Form1.Timer2.Enabled:= False;
end;

procedure TForm1.TreeView1DblClick(Sender: TObject);
var
 ssh1, ssh2 : THandle;
 pe32 : TProcessEntry32;
 me32 : TModuleEntry32;
 TrText,TrText1,a: string;
begin
  Form2.Show;
  Form2.Memo1.Clear;
  Form2.Memo2.Clear;
  TrText:=TreeView1.Selected.Text;
  TrText1:= Copy(TrText,Pos('*[',TrText)+2,10);
  a:= Copy(TrText1,1,Pos(']**',TrText1)-1);
  WindowName := StrToInt(a); // извлекаем хэндл из строки
  GetWindowThreadProcessId(WindowName, @ProcessId); //получаем ID процесса
         ssh1 := CreateToolhelp32Snapshot (TH32CS_SNAPPROCESS, 0);
         pe32.dwSize := SizeOf(pe32);
         me32.dwSize := SizeOf(me32);
   if Process32First(ssh1, pe32) then
   repeat
       ssh2 := CreateToolhelp32Snapshot (TH32CS_SNAPMODULE, pe32.th32ProcessID);
       if Module32First(ssh2, me32) then
       repeat
         if me32.th32ProcessID = ProcessID then
         Form2.Memo1.lines.add( me32.szExePath );
       until not Module32Next(ssh2, me32);
       CloseHandle(ssh2);
   until not Process32Next(ssh1, pe32);
       CloseHandle(ssh1);
       Form2.Memo2.Lines.Add(Form2.Memo1.Lines[0]);
       Form2.Memo1.Lines.Delete(0);
end;

procedure TForm1.WWMove(var Msg: TWMMove);
begin
 if Form2<>NIL then
MoveWindow(Form2.Handle, Form1.left+Form1.Width+3,
 Form1.Top, Form2.Width, Form2.Height, true) ;
end;

end.
