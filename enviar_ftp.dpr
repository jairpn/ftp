program enviar_ftp;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form33};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm33, Form33);
  Application.Run;
end.
