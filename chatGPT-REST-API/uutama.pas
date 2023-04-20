unit uutama;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdHTTP, IdSSLOpenSSL, IdGlobal, IdCoder,
  IdCoderMIME, Vcl.StdCtrls, IdURI, System.JSON, IdIOHandlerStack,
  FMX.Memo.Types, FMX.StdCtrls, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Edit;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function SendAPIRequest(APIToken: string; Prompt: string): string;
    function Base64Encode(Text: string): string;
    function Base64Decode(Text: string): string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.Base64Encode(Text: string): string;
var
  Encoder: TIdEncoderMIME;
begin
  Encoder := TIdEncoderMIME.Create(nil);
  try
    Result := Encoder.EncodeString(Text);
  finally
    Encoder.Free;
  end;
end;

function TForm1.Base64Decode(Text: string): string;
var
  Decoder: TIdDecoderMIME;
begin
  Decoder := TIdDecoderMIME.Create(nil);
  try
    Result := Decoder.DecodeString(Text);
  finally
    Decoder.Free;
  end;
end;

function TForm1.SendAPIRequest(APIToken: string; Prompt: string): string;
var
  IdHTTP: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  ResponseStream: TStringStream;
  RequestJSON: TJSONObject;
  ResponseJSON: TJSONObject;
  InputData: TStringStream;
  OutputData: TStringStream;
  URL: string;
begin
  URL := 'https://api.openai.com/v1/engines/davinci-codex/completions';
  IdHTTP := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  ResponseStream := TStringStream.Create('');
  InputData := TStringStream.Create('');
  OutputData := TStringStream.Create('');
  RequestJSON := TJSONObject.Create;
  ResponseJSON := TJSONObject.Create;
  try
    IdSSL.SSLOptions.Method := sslvTLSv1_2;
    IdHTTP.IOHandler := IdSSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.CustomHeaders.AddValue('Authorization', 'Bearer ' + APIToken);
    IdHTTP.Request.CustomHeaders.AddValue('OpenAI-Intent', 'Delphi ChatGPT Example');
    IdHTTP.Request.CustomHeaders.AddValue('OpenAI-User-Agent', 'Delphi ChatGPT Example');
    InputData.WriteString('{"prompt": "' + Prompt + '", "max_tokens": 100}');
    IdHTTP.Post(URL, InputData, OutputData);
    ResponseJSON := TJSONObject.ParseJSONValue(OutputData.DataString) as TJSONObject;
    Result := ResponseJSON.ToString; //GetValue('choices').Items[0].GetValue('text').Value;
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
  IdHTTP.Free;
  IdSSL.Free;
  ResponseStream.Free;
  InputData.Free;
  OutputData.Free;
  RequestJSON.Free;
  ResponseJSON.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  APIToken: string;
  Prompt: string;
begin
  APIToken := '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';
  Prompt := Edit1.Text;
  Memo1.Lines.Add('User: ' + Prompt);
  Prompt := Base64Encode(Prompt);
  Prompt := Prompt.Replace(#13#10, '');
  Prompt := Prompt.Replace('\', '\\');
  Prompt := Prompt.Replace('"', '\"');
  Memo1.Lines.Add('ChatGPT: ' + SendAPIRequest(APIToken, Prompt));
end;

end.

