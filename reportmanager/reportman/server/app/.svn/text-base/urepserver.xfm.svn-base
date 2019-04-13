object modserver: Tmodserver
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 358
  Top = 240
  Height = 172
  Width = 309
  object RepServer: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 3060
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnConnect = RepServerConnect
    OnExecute = RepServerExecute
    OnDisconnect = RepServerDisconnect
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    ThreadMgr = ThreadMan
    Left = 32
    Top = 12
  end
  object ThreadMan: TIdThreadMgrPool
    PoolSize = 1
    Left = 112
    Top = 60
  end
end
