unit umain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, system.Threading, FMX.Objects, FMX.TabControl,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  FMX.Layouts, FMX.ListBox;

type
  TForm1 = class(TForm)
    nHttpClient: TNetHTTPClient;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    ListView1: TListView;
    Button1: TButton;
    Button2: TButton;
    BtThread: TButton;
    TabItem2: TTabItem;
    mURL: TMemo;
    Image1: TImage;
    btDownload: TButton;
    AniIndicator1: TAniIndicator;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    btTest: TButton;
    procedure Button1Click(Sender: TObject);
    procedure BtThreadClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btDownloadClick(Sender: TObject);
    procedure btTestClick(Sender: TObject);
  private
    FProses : Boolean;
    FCount : Integer;

    procedure DownloadImage(url:string);
    procedure loading(isEnabled:boolean);


  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.loading(IsEnabled:Boolean);
begin
   TThread.Synchronize(TThread.CurrentThread, Procedure () Begin
     AniIndicator1.Enabled:=isEnabled;
   end)
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  sleep(1000); // perform some long-running operation
  listview1.items.Add.Text:='Without Thread';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TTask.Run(procedure () begin
     sleep(1000); // perform some long-running operation
     // since we are going to update tlistview, we have to use syncronize
     TThread.Synchronize(TThread.CurrentThread, Procedure () begin
        listview1.items.Add.Text:='This is using TTask';
     end);
   end);
end;


procedure TForm1.DownloadImage(url:string);
var ImageData : TMemoryStream;
begin

   ImageData := TMemorystream.Create;
   Try
     // use nethttpclient
     nHttpClient.Get(url,ImageData);
     // since we are going to update UI
     TThread.Synchronize(TThread.CurrentThread, Procedure () begin
     image1.Bitmap.LoadFromStream(ImageData);
     end);
   Finally
    ImageData.DisposeOf; // for mobile app
   End;
end;

procedure TForm1.btDownloadClick(Sender: TObject);
begin
  TTask.Run(Procedure () Begin
     Loading(TRue);
     Try
      DownloadImage(mURL.Text);
     Finally
      Loading(False);
     End;
   end);
end;

procedure TForm1.btTestClick(Sender: TObject);
begin
 murl.Lines.clear;
 murl.lines.add('https://cdn.britannica.com/05/236505-050-17B6E34A/Elon-Musk-2022.jpg');
end;

procedure TForm1.BtThreadClick(Sender: TObject);
begin
   TThread.CreateAnonymousThread(procedure () begin
     sleep(1000); // perform some long-running operation
     // since we are going to update tlistview, we have to use syncronize
     TThread.Synchronize(TThread.CurrentThread, Procedure () begin
        listview1.items.Add.Text:='With Anonymous Thread';
     end);
   end).Start;
end;

end.
