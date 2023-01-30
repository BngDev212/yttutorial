unit uLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmLogin = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    reInputs: TRectangle;
    Layout3: TLayout;
    Line1: TLine;
    lbusr: TLabel;
    edUserName: TEdit;
    Line2: TLine;
    lbPwd: TLabel;
    edPassword: TEdit;
    Circle1: TCircle;
    loInputs: TLayout;
    Image1: TImage;
    Label1: TLabel;
    cbShowPassword: TCheckBox;
    btLogin: TCornerButton;
    procedure cbShowPasswordChange(Sender: TObject);
    procedure edUserNameKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edPasswordKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure btLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses uDM, uMain;

procedure TFrmLogin.btLoginClick(Sender: TObject);
var pwd: string;
begin
   if trim(edUserName.Text)='' then
     begin
       Showmessage('Please enter user name ');
       edUserName.setfocus;
     end
     else
     begin
       // validate the username and password
       with dm do begin
        dbShopping.open;
        qTemp.sql.clear;
        qTemp.Sql.Text:='Select * From users Where username='+quotedstr(edUserName.Text);
        // checking if the username is in the database
        qtemp.Open;
        if qtemp.RecordCount > 0 then
        begin
           pwd:=qtemp.FieldByName('password').AsString;
           if pwd=edPassword.Text then
            begin
              // valid user & password, go to main menu
              // hide frmLogin & Create and show Main Menu
              // login success
                 frmLogin.Hide;
                 //show main menu
                if not Assigned(frmMain) then
                frmMain:= TfrmMain.Create(self);
                frmMain.lusr.text:='User Name: '+edUserName.Text;
                frmMain.ShowModal(
                            procedure(ModalResult: TModalResult)
                            begin

                              if ModalResult = mrClose then Application.Terminate;

                            end);


            end
            else
            begin
              showmessage(' Incorrect Password ');
            end;
        end
        else begin
          // does not exist
          showmessage(' User name not valid');
        end;


       end;// end with
     end;
end;

procedure TFrmLogin.cbShowPasswordChange(Sender: TObject);
begin
 edPassword.Password:= not cbShowPassword.IsChecked;
end;

procedure TFrmLogin.edPasswordKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if key=vkreturn  then btLogin.setfocus;
end;

procedure TFrmLogin.edUserNameKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if key=vkreturn  then edpassword.setfocus;

end;

end.
