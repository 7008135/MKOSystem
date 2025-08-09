object FrameTask: TFrameTask
  Left = 0
  Top = 0
  Width = 620
  Height = 510
  Align = alClient
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 332
    Top = 35
    Height = 475
    ExplicitLeft = 328
    ExplicitTop = 328
    ExplicitHeight = 100
  end
  object vleParamsTask: TValueListEditor
    AlignWithMargins = True
    Left = 3
    Top = 38
    Width = 326
    Height = 469
    Align = alLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TitleCaptions.Strings = (
      #1057#1074#1086#1081#1089#1090#1074#1086
      #1047#1072#1087#1086#1083#1085#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077)
    OnMouseMove = vleParamsTaskMouseMove
    ColWidths = (
      106
      214)
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 1
    Top = 3
    Width = 616
    Height = 32
    Margins.Left = 1
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = -368
    ExplicitWidth = 988
    object sbtnStart: TSpeedButton
      AlignWithMargins = True
      Left = 2
      Top = 1
      Width = 30
      Height = 30
      Margins.Left = 2
      Margins.Top = 1
      Margins.Right = 2
      Margins.Bottom = 1
      Action = actStart
      Align = alLeft
      Images = VirtualImageList1
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = -12
    end
    object spbtnStop: TSpeedButton
      AlignWithMargins = True
      Left = 36
      Top = 1
      Width = 30
      Height = 30
      Margins.Left = 2
      Margins.Top = 1
      Margins.Right = 2
      Margins.Bottom = 1
      Action = actStop
      Align = alLeft
      Images = VirtualImageList1
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 2
    end
    object SpeedButton1: TSpeedButton
      AlignWithMargins = True
      Left = 70
      Top = 1
      Width = 30
      Height = 30
      Margins.Left = 2
      Margins.Top = 1
      Margins.Right = 2
      Margins.Bottom = 1
      Align = alLeft
      ImageIndex = 1
      ImageName = 'icons8-stop'
      Images = VirtualImageList1
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
      ExplicitLeft = 104
    end
  end
  object Panel2: TPanel
    Left = 335
    Top = 35
    Width = 285
    Height = 475
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 392
    ExplicitTop = 160
    ExplicitWidth = 185
    ExplicitHeight = 41
    object prbrProcessTask: TProgressBar
      AlignWithMargins = True
      Left = 3
      Top = 455
      Width = 279
      Height = 17
      Align = alBottom
      Style = pbstMarquee
      State = pbsPaused
      TabOrder = 1
      ExplicitWidth = 282
    end
    object ListBox1: TListBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 279
      Height = 446
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      ExplicitLeft = 56
      ExplicitTop = 128
      ExplicitWidth = 121
      ExplicitHeight = 97
    end
  end
  object alMain: TActionList
    Images = VirtualImageList1
    Left = 16
    Top = 456
    object actStart: TAction
      ImageIndex = 0
      OnExecute = actStartExecute
    end
    object actStop: TAction
      ImageIndex = 1
      OnExecute = actStopExecute
    end
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'icons8-start'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              38000000097048597300000B1300000B1301009A9C180000051A49444154789C
              ED9D4D881C4514C7CB881FF12268148C1BA76A12A278CD3528821AC44FFC3E78
              D72806837ACE350757DDECBC370C11058F7B3189A7A8C7F871588C1FB8077156
              099BE4A06E32EFCD0E0AC996BC9E4990C0B2B3DB555D553DF5830721D92C55FF
              7F777575BDAAD74A6532994C2693C96432994C443491EFD4D8DFA7910F6864D0
              485F69A49F0C72D7202F6BA07F25E4CFF277F26F1AE9CBE26781DFD4D07F74D7
              0CDD11BA1FC97057C7DEA25BF4B4019A2984065A35C8B65400AD0E4DA30F35F6
              9E9A9AB65B43F7332E0ED92DCD16ED35C81D8DDC2B2DF8BA4103833C67A0F7A4
              9AB3D7AB49A5F189BDD900BD6E9017FD8BBE66749B48FBA52D6AA28619E8BF63
              80CE0514FEDA614ADAF2B6B44DD519B9ED0DF0EFC105C7358D5832C82FA8BAD1
              685FD01AF8F3E002E3B846F071DD1A34541D68003D339A26DA944223F734F04B
              2A5576CDD89B643A195A48533E3AD2179512DB677BB71BE06F2310CF3ABA1BBE
              9E3A7AF13695023B6657B68FDE566DCD62A1D919DCA362A6D1A1FB34D29908C4
              B27EEE043A237D543132D55EB9DB20FD115A24E33B8096A29B2115633EF24270
              71B0A23B01F857592854F1CC76EAF3C03563DF09FC4D14B3230DD40A2E06860A
              3A12547CD3A2E7C38BC0A14D782EE4F2C2C5F00270E8B810E4A1AC914F44D079
              1B45001F0FB1BE13BEE318514882A70A64CD7C22E6FBB8E158AC24DDA9B1F76E
              049DB551468B0FFA9FF3239DF5D1F8F9F397EC2B2706E1452C1574DEEB5D30CA
              E17A69FC155237A201F49A1FF50FD92D3E13E8D792B0115D65ED75CEF56F003F
              E4B3E16B91A2111AE841E70668E48F431890A2111AF923A7E2CB83C5F75BEFB8
              A46084E4939D3E8C8BED829E1BBD51E237A2F7843303AA48AE6F96588DD048D3
              CE0CA822C75B96F88CA0D34EC497CC8F935DCA9E0D88CF08BABCBB43DB1C5CFD
              FD7D5534D8359118F1B00303F8408A064462C41B2E0C80940D086B848394A51C
              F9A98301618CA093E50D00FAB94E0654698446FAB1B40155255F42E1D988C5F2
              0600FF5D67037C1AA181FF2C6DC0E81868ED0DF0618446FA271B90BA017908E2
              B043507E0873D887709E8672D869687E11E3C02F627929C2065E8AC88B7126EC
              625C5E8E362197A3A5DE4E4EC8F026822ECBD1ADD2060CEF829C92341B0DA0EF
              952BA4D851AC06CCC726FC2834D07BCE0C904A53B119301FA9F057A209BDC79D
              1990376671D88D5942DE9AC8E31B007C54B9266FCEE5F10D68D103BEB6A777AB
              32603E41E10BF1817FF3B23D5DC80734787D03DAF4AA4AF188D277672FD9978F
              A52B7C1140E7BC576094EA82C13B8A714603F92D55C931D5982B1F62B0E85656
              95B781FDC722E8B0ADED798071C8A50AF8FFF159A5E21706B4060D29541141E7
              6DE0580E564B6E5809D7FF52B5893580569B40CF0611FFAA09484726D8800F54
              68E4DD40EA6A061703AB0D0D7CEAFE397BA38A816667F956D9823139573EFF12
              5D21D7492A5BD98CB580EB24146ED5D8BB572550BAB88EC3D1C24E18EC502920
              E3A3D4D5ACCD950F7C2ABA317F3DF674EC0D06F9700DDE133AD1CC764AD49948
              F3030E6D7E51D50159B6486CEDE858B4339DD24B17613F5B65D789AED3ED2431
              52E4135A7CD05766CD6C268096249932515FD993258C26D27E9F89FE71AE7829
              B2174515F490ECC4953DA39A447FF916BDD86006F469B173D9D7EE8554999AB6
              5B25B3A491DE37403FC80EE3F2A2CBEFA0D3524049C6F789FA6C61597677689B
              69F32372D04103CD6AA02F86C670574E6F5EFD9CEDF024677764DA49F959F93F
              72953BA9D993C96432994C2693C96432CA1DFF01553C775DBC0768A500000000
              49454E44AE426082}
          end>
      end
      item
        Name = 'icons8-stop'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000006400000064080600000070E295
              54000000097048597300000B1300000B1301009A9C18000000FE49444154789C
              EDD1410D020010C4C0D3B002F0857F2120009E24F4314D4641EF244992244992
              244952A9D7EEC57D30642D86ACC590B518B21643D662C85A0C598B216B31642D
              86ACC590B518B21643D662C85A0C598B216B31642D86ACC590B518B21643D662
              C85A0C598B216B31642D86ACC590B518B21643D662C85A0C598B216B31642D86
              ACC590B518B21643D662C85A0C598B216B31642D86ACC590B518B21643D662C8
              5A0C598B216B31642D86ACC590B518B21643D662C85A0C598B216B31642D86AC
              C590B518B21643D662C85A0C598B216B31642D86ACC590B518B21643D6F2B721
              77F7E4BE31E45A0CB996BFF5E0BE912449922449D2FDBC37B042CDC0EB1F282C
              0000000049454E44AE426082}
          end>
      end>
    Left = 504
    Top = 392
  end
  object VirtualImageList1: TVirtualImageList
    AutoFill = True
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'icons8-start'
        Disabled = False
        Name = 'icons8-start'
      end
      item
        CollectionIndex = 1
        CollectionName = 'icons8-stop'
        Disabled = False
        Name = 'icons8-stop'
      end>
    ImageCollection = ImageCollection1
    Width = 24
    Height = 24
    Left = 400
    Top = 400
  end
end
