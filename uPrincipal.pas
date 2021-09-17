unit uPrincipal;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, IdBaseComponent,
    IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
    IdFTP, Vcl.StdCtrls, Vcl.ExtCtrls, IniFiles;

type
    TForm33 = class(TForm)
        IdFTP1: TIdFTP;
        Btn_Conectar: TButton;
        Memo_Relatorio_FTP: TMemo;
        Shape_Conectado: TShape;
        Btn_Desconectar: TButton;
        btn_Upload: TButton;
        OpenDialog1: TOpenDialog;
        Edit_Host: TEdit;
        Edit_Name: TEdit;
        Edit_Senha: TEdit;
        btnSair: TButton;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Bevel1: TBevel;
        procedure Btn_ConectarClick(Sender: TObject);
        procedure Btn_DesconectarClick(Sender: TObject);
        procedure btn_UploadClick(Sender: TObject);
        procedure btnSairClick(Sender: TObject);
        procedure FormShow(Sender: TObject);
        private
            { Private declarations }
        public
            { Public declarations }
    end;

var
      Form33: TForm33;
    Diretorio_Leitura: String;

implementation

{$R *.dfm}

{ TForm33 }

procedure TForm33.btnSairClick(Sender: TObject);
begin
    Close;
end;

procedure TForm33.Btn_ConectarClick(Sender: TObject);
var
      ArquivoINI: TIniFile;
begin
    Screen.Cursor := -17;
    ArquivoINI := TIniFile.Create('C:\ftp.ini');
    ArquivoINI.WriteString('Host', 'host', Edit_Host.Text);
    ArquivoINI.WriteString('Host', 'usuario', Edit_Name.Text);
    ArquivoINI.Free;


    Application.ProcessMessages;
    Memo_Relatorio_FTP.Lines.Clear;
    IdFTP1.Host := Edit_Host.Text;
    IdFTP1.Username := Edit_Name.Text;
    IdFTP1.Password := Edit_Senha.Text;

    try
        IdFTP1.Connect;
    except
        ShowMessage('Não foi possível conectar ao FTP!');
        Screen.Cursor := 0;
        exit;
    end;

    if IdFTP1.Connected = True Then
        begin
            Shape_Conectado.Brush.Color := clLime;
            Shape_Conectado.Pen.Color := clLime;
        end;

    Memo_Relatorio_FTP.Lines.Add(' Conectado ao endereço: ' + IdFTP1.Host);
    Memo_Relatorio_FTP.Lines.Add(' Servidor remoto: ' + IdFTP1.SystemDesc);
    Memo_Relatorio_FTP.Lines.Add('');

    btn_Upload.Enabled := True;
    Btn_Desconectar.Enabled := True;
    Btn_Conectar.Enabled := False;

    Screen.Cursor := 0;
end;

procedure TForm33.Btn_DesconectarClick(Sender: TObject);
begin
    Memo_Relatorio_FTP.Lines.Clear;
    Screen.Cursor := -17;
    Application.ProcessMessages;
    try
        IdFTP1.Disconnect;
    finally
        if IdFTP1.Connected = False then
            begin
                Shape_Conectado.Brush.Color := clRed;
                Shape_Conectado.Pen.Color := clRed;
            end;

        Memo_Relatorio_FTP.Lines.Add('Desconectado ');
        Memo_Relatorio_FTP.Lines.Add('');

        btn_Upload.Enabled := False;
        Btn_Desconectar.Enabled := False;
        Btn_Conectar.Enabled := True;
    end;
    Screen.Cursor := 0;
end;

procedure TForm33.btn_UploadClick(Sender: TObject);
var
      m: TStream;
    f: TStream;
    t: Cardinal;
    Nome_Arquivo,
      Auxiliar: String;
    contador: Integer;
begin
    Auxiliar := '';
    f := nil;
    m := nil;

    Memo_Relatorio_FTP.Lines.Add(' Diretório original: ' + Diretorio_Leitura);
    OpenDialog1.Filter := ' Arquivos (* . *) | *.*';

    if OpenDialog1.Execute then
        begin

            Nome_Arquivo := ExtractFileName(OpenDialog1.FileName);

            Memo_Relatorio_FTP.Lines.Add(' Operação: troca de Diretório local ');
            Memo_Relatorio_FTP.Lines.Add(' Diretório do arquivo: ' + GetCurrentDir);
            Memo_Relatorio_FTP.Lines.Add('');

            for contador := 1 To StrLen(PCHar(Nome_Arquivo)) do
                Auxiliar := Auxiliar + Nome_Arquivo[contador];
            Nome_Arquivo := Auxiliar;

            try
                Memo_Relatorio_FTP.Lines.Add(' Operação: Upload ');
                Memo_Relatorio_FTP.Lines.Add(' arquivo local: ' + OpenDialog1.FileName);
                Memo_Relatorio_FTP.Lines.Add(' Gravado como: ' + Nome_Arquivo);

                f := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
                m := TMemoryStream.Create;
                m.CopyFrom(f, f.Size);
                m.Seek(0, 0);
                t := GetTickCount;
                IdFTP1.Put(m, Nome_Arquivo);

                Memo_Relatorio_FTP.Lines.Add(Format(' tempo % d milesegundos ', [GetTickCount - t]));
                Memo_Relatorio_FTP.Lines.Add(Format(' Tamanho % d bytes ', [m.Size]));
                Memo_Relatorio_FTP.Lines.Add('');

            finally
                m.Free;
                f.Free;
            end;
        end;
    SetCurrentDir(Diretorio_Leitura);
    Memo_Relatorio_FTP.Lines.Add(' Operação: troca de diretorio local ');
    Memo_Relatorio_FTP.Lines.Add(' Diretório após a Operação: ' + GetCurrentDir);
    Memo_Relatorio_FTP.Lines.Add('');

end;

procedure TForm33.FormShow(Sender: TObject);
var
      ArquivoINI: TIniFile;
    Mensagem, usuario: string;
begin
    ArquivoINI := TIniFile.Create('C:\ftp.ini');
    Mensagem := ArquivoINI.ReadString('Host', 'host', '');
    usuario := ArquivoINI.ReadString('Host', 'usuario', '');
    Edit_Host.Text := Mensagem;
    Edit_Name.Text := usuario;
    ArquivoINI.Free;

end;

end.
