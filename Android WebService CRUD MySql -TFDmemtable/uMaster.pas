unit uMaster;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox,System.Net.Mime,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Edit, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo;


type
  TFrmMaster = class(TForm)
    Layout1: TLayout;
    tcMaster: TTabControl;
    TiListData: TTabItem;
    TiEntryData: TTabItem;
    Ltop: TLayout;
    LbData: TListBox;
    Lbottom: TLayout;
    ToolBar1: TToolBar;
    btRefresh: TCornerButton;
    MemData: TFDMemTable;
    Layout2: TLayout;
    btBack: TCornerButton;
    Layout3: TLayout;
    edAccount: TEdit;
    LbAccount_desc: TLabel;
    Layout4: TLayout;
    btDelete: TCornerButton;
    btSave: TCornerButton;
    btAdd: TSpeedButton;
    btExit: TSpeedButton;
    logs: TMemo;
    procedure btRefreshClick(Sender: TObject);
    function  fnUpdateItem: boolean;
    function  fnInsertItem : boolean;
    function  fnDeleteItem : Boolean;
    procedure FormShow(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure LbDataItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure btAddClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
  private
    FDataID   : String;
    FProcess : String;
    Procedure ListData;
    function  GetDataId(account_desc:string) : string;

  public
    { Public declarations }
  end;

var
  FrmMaster: TFrmMaster;

implementation

{$R *.fmx}
uses BFA.Helper.MemTable;

const
  cINSERT     = 'INSERT';
  cUPDATE     = 'UPDATE';
  APIROOT     = 'http://localhost/yttutorial/CRUDAPI';//'https://tmdeasy.000webhostapp.com/yttutorial/CRUDAPI';//'https://tmdeasy.000webhostapp.com/yttutorial/CRUDAPI';//'http://localhost/yttutorial/CRUDAPI';

function TFrmMaster.GetDataId(account_desc:string) : string;
var r: integer;
begin
  r:=-1;

  if memdata.Locate('account_desc', VarArrayOf([account_desc]),[]) then
     r:=memData.FieldByName('account_id').AsInteger;

  result:=inttostr(r);

end;

// CRUD functions
// function to update data based on account_id
function TFrmMaster.fnUpdateItem: boolean;
var
  dtpart : TMultipartFormData;
begin
  result:=true;
  dtpart := TMultipartFormData.Create();
  try

    dtpart.AddField('tbl', 'accounts');
    dtpart.AddField('val', Format('account_desc = ''%s''',
      [
        edAccount.Text
      ]
    ));
    dtpart.AddField('isWhere', 'account_id = ' + QuotedStr(FdataID));
    if not memData.FillDataFromURL(APIROOT+'/APICrud.php?act=updateItem', dtpart) then begin
      ShowMessage('Update Failed');
      result:=false;
      Exit;
    end;
    edAccount.Text := '';
finally
    dtpart.DisposeOf;
  end;

  ListData;
  tcMaster.Previous;

end;      procedure TFrmMaster.FormShow(Sender: TObject);
begin
 tcMaster.TabIndex:=0;
end;

// and of procedure fnUpdate Item



function TFrmMaster.fnInsertItem : boolean;
var
  dtpart : TMultipartFormData;
begin
  result:=true;

  dtpart := TMultipartFormData.Create();
  try
    // function.php:
    // function fnInsertItem($conn, $tbl, $kol, $val)
    // "INSERT INTO ".$tbl." (".$kol.") VALUES (".$val.")";

    dtpart.AddField('tbl', 'accounts');
    dtpart.AddField('kol', 'account_desc');
    dtpart.AddField('val', Format('''%s''',
      [
        edAccount.Text
      ]
    ));
    dtpart.AddField('isWhere', 'account_desc = ' + QuotedStr(edAccount.Text));
    if not memData.FillDataFromURL(APIROOT+'/APICrud.php?act=insertItemIsNull', dtpart) then
      begin
      ShowMessage('Insert Data Failed');
      result:=true;
      Exit;
    end;
    edAccount.Text := '';

  finally
    dtpart.DisposeOf;
  end;

      ListData;
      tcMaster.Previous;
end;

Function  TFrmMaster.fnDeleteItem : Boolean;
var
  dtpart : TMultipartFormData;
begin

  //   deleteItemWhere ->> fnDeleteItemWhere($connection, $_POST['tbl'], $_POST['isWhere']);
  //     "DELETE FROM ".$nmTable." WHERE ".$isWhere."";

  dtpart := TMultipartFormData.Create();
  try
    dtpart.AddField('tbl','accounts');
    dtpart.AddField('isWhere','account_id='+ FDataID);
    if not memData.FillDataFromURL(APIROOT+'/APICrud.php?act=deleteItemWhere',dtpart) then begin
      ShowMessage(memData.FieldByName('message').AsString);
      Exit;
    end;
    edAccount.Text := '';
    tcMaster.Previous;
  finally
    dtpart.DisposeOf;
  end;

  ListData;
end;

procedure TFrmMaster.LbDataItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
if LbData.Items.Count <=0 then exit;

    FProcess        := cUPDATE;
    edAccount.Text  := Item.Text;           //lbData.listItems[lbData.ItemIndex].Text;
    FDataID         := inttostr(Item.Tag); //inttostr(lbData.listItems[lbData.ItemIndex].Tag);//GetDataId(edAccount.Text);
    LbAccount_desc.Text  := 'Account Description Id: '+ FDataID ;

    tcMaster.Next;
end;

Procedure  TFrmMaster.ListData;
var
  i: Integer;
  ListBoxItem : TListBoxItem;
  ListBoxGroupHeader : TListBoxGroupHeader;
  dtpart : TMultipartFormData;
  iTag : Integer;

begin

  dtpart := TMultipartFormData.Create();
  try
    dtpart.AddField('tbl', 'accounts');  // table name = accounts
    dtpart.AddField('val', '*');         // all column
    dtpart.AddField('isWhere', '');
    dtpart.AddField('order', 'ORDER BY account_id ASC');
    dtpart.AddField('limit', '10');      // max 10 row

    // Select * from accounts ORDER BY account_id ASC

    if not memData.FillDataFromURL(APIROOT+'/APICrud.php?act=loadItem', dtpart) then begin
      ShowMessage('Read Failed ');
      Exit;
    end;

    lbData.Clear;    // clear all  data in list box
    //
    lbData.BeginUpdate;

    ListBoxGroupHeader := TListBoxGroupHeader.Create(lbData);
    ListBoxGroupHeader.Text := 'Accounts'; // the data if from table account
    ListBoxGroupHeader.StyledSettings:=[];
    ListBoxGroupHeader.Height:=30;
    ListBoxGroupHeader.TextSettings.Font.Style:=[TFontStyle.fsBold];
    lbData.AddObject(ListBoxGroupHeader);

    for i := 0 to memData.RecordCount - 1 do begin
      // add items
    if memData.FieldByName('account_desc').AsString <> null then
     begin
      ListBoxItem := TListBoxItem.Create(lbData);
      ListBoxItem.Text := memData.FieldByName('account_desc').AsString;   // just need to display data form column account_desc
      iTag:=memData.FieldByName('account_id').AsInteger;
      ListBoxItem.Tag:=iTag;
      // (aNone=0, aMore=1, aDetail=2, aCheckmark=3)
      ListBoxItem.ItemData.Accessory := TListBoxItemData.TAccessory(1);    //
      lbData.AddObject(ListBoxItem);
     end;

      memData.Next;
    end;

    lbData.EndUpdate;

  finally
    dtpart.DisposeOf;
  end;


  lbData.SetFocus;
  if lbData.items.Count>1 then
    lbData.ItemIndex:=1;
end;




// end of procedure Listdata

procedure TFrmMaster.btAddClick(Sender: TObject);
begin
  FProcess := cINSERT;     //
  edAccount.Text := '';
  lbAccount_desc.Text := 'Account Description';
  tcMaster.Next;
end;

procedure TFrmMaster.btBackClick(Sender: TObject);
begin
      FDataID := '';
   tcMaster.Previous;
end;

procedure TFrmMaster.btDeleteClick(Sender: TObject);
begin
    fnDeleteItem;
end;

procedure TFrmMaster.btExitClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TFrmMaster.btRefreshClick(Sender: TObject);
begin
  ListData;
end;

procedure TFrmMaster.btSaveClick(Sender: TObject);
begin
    if FProcess = cUPDATE then
    fnUpdateItem
  else if FProcess = cINSERT then
    fnInsertItem;
end;

end.
