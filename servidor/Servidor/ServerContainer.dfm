object FServerContainer: TFServerContainer
  OldCreateOrder = False
  Left = 473
  Top = 415
  Height = 162
  Width = 445
  object DSServer: TDSServer
    AutoStart = False
    HideDSAdmin = False
    Left = 40
    Top = 11
  end
  object DSHTTPService: TDSHTTPService
    RESTContext = 'restT2Ti'
    Server = DSServer
    DSHostname = 'localhost'
    DSPort = 211
    Filters = <>
    AuthenticationManager = DSHTTPServiceAuthenticationManager
    HttpPort = 8080
    Active = False
    Left = 136
    Top = 15
  end
  object DSHTTPServiceAuthenticationManager: TDSHTTPServiceAuthenticationManager
    HTTPAuthenticate = DSHTTPServiceAuthenticationManagerHTTPAuthenticate
    Left = 296
    Top = 16
  end
end
