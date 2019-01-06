<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TCC.aspx.cs" Inherits="TravelCompTime.TCC" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title> Travel Comp Time Calculator</title>
     <script type="text/javascript" src="Scripts/jquery-1.7.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
      <script>
          $(document).ready(function () {
              var FlagFormat = true;

              var cellHH;
           
              $("#t1").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(1, e);
                  }
              });
                        

              function qualify(ind,e) {
                  {
                      var tempTT;
                      if (tempTT === "") {
                          $("#lblT" + ind).text("0:00");
                          return;
                      }

                      tempTT = $('#t' + ind).val();
                      if (tempTT.substring(1, 2) === ":") {
                          tempTT = "0" + tempTT;
                      }
                      tempTT = propHHMM(tempTT);
                      if (FlagFormat) {
                          $("#lblT"+ind).text(tempTT);                          
                      }
                      else {
                      //    alert($('input[name=rbBefore]:radio:checked').val());
                          e.preventDefault();
                      }
                      
                      return;
                  }
              }

              function normalize(ind) {
                  {
                      var tempTT;
                      if (tempTT === "") {
                          $("#lblT" + ind).text("0:00");
                          return;
                      }
//                      alert(ind + " ind");
                      tempTT = $('#t' + ind).val();
                      if (tempTT.substring(1, 2) === ":") {
                          tempTT = "0" + tempTT;
                      }
                      tempTT = propHHMM(tempTT);

                      if (ind === 2) {
                          var hh = tempTT.split(":")[0];
                          var mm = tempTT.split(":")[1];
                          if (hh > 1) {
                              tempTT = $("input[name='rbBefore']:checked").val();
                          }
                          if ($("input[name='rbBefore']:checked").val() === "01:30") {
                              if (hh === 1 && mm > 30) {
                                      tempTT = "1:30";                                  
                              }
                          }
                      }

                      if (ind === 12) {
                          var hh = tempTT.split(":")[0];
                          var mm = tempTT.split(":")[1];
                          if (hh > 1) {
                              tempTT = $("input[name='rbBefore']:checked").val();
                          }
                          if ($("input[name='rbBefore']:checked").val() === "01:30") {
                              if (hh === 1 && mm > 30) {
                                  tempTT = "01:30";
                              }
                          }
                      }

                      if ((ind === 4) || (ind === 6) || (ind === 14) || (ind === 16))
                      {
                          var hh = tempTT.split(":")[0];
                          if (hh > 1) {
                              tempTT = "02:00";
                          }
                      }



                      if (FlagFormat) {
                          $("#lblT" + ind).text(tempTT);
                      }
                      else {
                          $("#t" + ind).css("background-color", "#FFDDDD")
                      }


                      return;
                  }
              }

              $("#btnCalc0").click(function () {
                  tot();
              });

              $("#btnCalc").click(function () {
                  tot();
              });

              $("#btnPrint").click(function () {
                  tot();
                  window.print();
              });

              $("#btnClose").click(function () {
                  var win = window.open("about:blank", "_self");
                  win.close();
              });

              
             function tot() {
                 var i; var sum = 0; var sum2 = 0; var tempo; var tempo2;
                 var time1H = "";
                 var time1M = "";
                 var tot1H = 0;
                 var tot1M = 0;
                 var tot2H = 0;
                 var tot2M = 0;
                 for (i = 1; i < 19; i++) {
                     if (i < 9) {
                         normalize(i)
                         tempo = $("#lblT" + i);
                         tempo2 = tempo.text();
                         time1H = tempo2.split(":")[0];
                         time1M = tempo2.split(":")[1];
                             
                         tot1M = parseInt(tot1M) + parseInt(time1M);
                         tot1H = parseInt(tot1H) + parseInt(time1H);
                         if (parseInt(tot1M) > 59) {
                             tot1M = parseInt(tot1M) - 60;
                             tot1H = parseInt(tot1H) + 1;
                         }                                                                           
                     }

                     if (i > 10) {
                         normalize(i)
                         tempo = $("#lblT" + i);
                         tempo2 = tempo.text();
                         time1H = tempo2.split(":")[0];
                         time1M = tempo2.split(":")[1];
                         tot2M = parseInt(tot2M) + parseInt(time1M);
                         tot2H = parseInt(tot2H) + parseInt(time1H);
                         if (parseInt(tot2M) > 59) {
                             tot2M = parseInt(tot2M) - 60;
                             tot2H = parseInt(tot2H) + 1;
                         }
                     }
                      
                 } //for
                                      
                      var stp = $("input[name='rbStatus']:checked").val();
                      
                      tot1M = Math.round(parseInt(tot1M) / stp) * stp;
                      tot2M = Math.round(parseInt(tot2M) / stp) * stp;

                      if (tot1M === 60) {
                          tot1M = 0; tot1H = parseInt(tot1H) + 1;
                      }
                      if (tot2M === 60) {
                          tot2M = 0; tot2H = parseInt(tot2H) + 1;
                      }
                      if (String(tot1M).length === 1) {
                          tot1M = "0" + tot1M;
                      }
                      if (String(tot2M).length === 1) {
                          tot2M = "0" + tot2M;
                      }

                      $("#lblTotal1").text(tot1H + ":" + tot1M);
                      $("#lblTotal2").text(tot2H + ":" + tot2M);                                    
             }
              

              
              function propHHMM() {
                  var rawTime = arguments[0];
                  if (rawTime.substring(1, 2) === ":") {
                      rawTime = "0" + rawTime;
                  }

                  var regexp = /([01][0-9]|[02][0-3]):[0-5][0-9]/;
                  var correct = (rawTime.search(regexp) >= 0) ? true : false;
                  if (correct === true) {
                      rawTime = rawTime.substring(0, 5);
                      FlagFormat = true;
                  }
                  else {
                      alert("Please use proper format -- hh:mm or h:mm");
                      rawTime = "0:00";
                      FlagFormat = false;
                  }
                  return rawTime;
              }


              $('input').keypress(function (e) {
                  if (e.which == 13) {
                      var newInd = parseInt(($(this).attr("tabindex"))) + 1;
                      $("[tabindex='" + newInd + "']").focus();
                      e.preventDefault();
                  }
              });

              $("#t2").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(2, e);
                  }
              });
              $("#t3").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(3, e);
                  }
              });
              $("#t4").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(4, e);
                  }
              });
              $("#t5").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(5, e);
                  }
              });
              $("#t6").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(6, e);
                  }
              });
              $("#t7").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(7, e);
                  }
              });
              $("#t8").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(8, e);
                  }
              });
              $("#t13").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(13, e);
                  }
              });
              $("#t12").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(12, e);
                  }
              });
              $("#t11").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(11, e);
                  }
              });
              $("#t14").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(14, e);
                  }
              });
              $("#t15").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(15, e);
                  }
              });
              $("#t16").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(16, e);
                  }
              });
              $("#t17").keydown(function (e) {
                  if ((e.keyCode == 9) || (e.keyCode == 13)) {
                      qualify(17, e);
                  }
              });           
            
          });

       </script>
    <style>
  /*lbl {
    display: inline-block;
    width: 5em;
  }*/   

</script>


    <style type="text/css">
        .auto-style1 {
            width: 100%;
            border-style: none;
        }
        .auto-style2 {
            font-family: Arial;
        }
        .auto-style21 {
            font-size: small;
        }
        .auto-style31 {
            text-align: left;
        }
        .auto-style32 {
            font-size: large;
        }
        .auto-style45 {
            width: 100%;
        }
        .auto-style46 {
            width: 202px;
            font-size: small;
        }
        .auto-style48 {
            width: 202px;
            font-size: small;
            font-family: Arial;
        }
        .auto-style49 {
            width: 344px;
        }
        .auto-style50 {
            width: 202px;
            font-size: small;
            height: 26px;
        }
        .auto-style51 {
            font-size: small;
            height: 26px;
        }
        .auto-style53 {
            width: 345px;
        }
        .auto-style55 {
            font-size: medium;
        }
        .auto-style56 {
            font-size: small;
            width: 760px;
        }
        .auto-style60 {
            font-size: x-large;
        }
        .auto-style61 {
            font-family: "Browallia New";
        }
        .auto-style62 {
            font-family: "Browallia New";
            font-size: medium;
        }
        .auto-style63 {
            font-size: small;
            height: 26px;
            font-family: Arial;
            background-color: #C0C0C0;
            text-align: center;
        }
        .auto-style64 {
            font-size: medium;
            background-color: #CFD6E5;
            width: 234px;
        }
        .auto-style65 {
            font-size: small;
            width: 760px;
            background-color: #EEEEF2;
        }
        .auto-style66 {
            font-size: medium;
            font-family: Arial;
            background-color: #EEEEF2;
        }
        .auto-style67 {
            font-size: medium;
            text-align: center;
            background-color: #CFD6E5;
        }
        .auto-style68 {
            border-style: solid;
            border-width: 2px;
            width: 100%;
        }
        .auto-style69 {
            font-size: medium;
            font-family: Arial;
        }
        .auto-style70 {
            font-size: medium;
            font-family: Arial;
            background-color: #CFD6E5;
        }
        .auto-style71 {
            font-size: medium;
            width: 760px;
            background-color: #CFD6E5;
        }
        .auto-style72 {
            font-weight: bold;
        }
        .auto-style73 {
            font-size: small;
            width: 760px;
            height: 26px;
        }
        .auto-style74 {
            font-size: medium;
            font-family: Arial;
            height: 26px;
        }
        .auto-style75 {
            font-size: small;
            width: 757px;
            background-color: #EEEEF2;
            height: 26px;
        }
        .auto-style76 {
            font-size: medium;
            font-family: Arial;
            background-color: #EEEEF2;
            height: 26px;
            width: 282px;
        }
        .auto-style77 {
            text-align: right;
        }
        .auto-style78 {
            text-align: right;
            width: 1019px;
        }
        .auto-style80 {
            font-weight: normal;
        }
        .auto-style81 {
            font-size: small;
            width: 757px;
            background-color: #CFD6E5;
        }
        .auto-style82 {
            font-size: small;
            width: 757px;
            background-color: #EEEEF2;
        }
        .auto-style83 {
            font-size: small;
            width: 757px;
        }
        .auto-style84 {
            font-size: small;
            width: 757px;
            height: 26px;
        }
        .auto-style85 {
            font-size: medium;
            width: 757px;
            background-color: #CFD6E5;
        }
        .auto-style86 {
            font-size: small;
            height: 26px;
            width: 396px;
        }
        .auto-style87 {
            font-size: small;
            width: 396px;
            font-family: Arial;
        }
        .auto-style88 {
            font-size: small;
            width: 760px;
            background-color: #CFD6E5;
        }
        .auto-style89 {
            font-size: medium;
            text-align: center;
            background-color: #CFD6E5;
            width: 258px;
        }
        .auto-style90 {
            font-size: medium;
            width: 258px;
        }
        .auto-style91 {
            font-size: medium;
            font-family: Arial;
            background-color: #EEEEF2;
            width: 258px;
        }
        .auto-style92 {
            font-size: medium;
            font-family: Arial;
            height: 26px;
            width: 258px;
        }
        .auto-style93 {
            font-size: medium;
            font-family: Arial;
            width: 258px;
        }
        .auto-style94 {
            font-size: medium;
            background-color: #CFD6E5;
            width: 258px;
        }
        .auto-style95 {
            width: 231px;
            font-size: small;
            height: 26px;
        }
        .auto-style96 {
            width: 231px;
            font-size: small;
            font-family: Arial;
        }
        .auto-style97 {
            width: 231px;
            font-size: small;
        }
        .auto-style98 {
            font-size: medium;
            text-align: center;
            background-color: #CFD6E5;
            width: 234px;
        }
        .auto-style99 {
            font-size: medium;
            width: 234px;
        }
        .auto-style100 {
            font-size: medium;
            font-family: Arial;
            background-color: #EEEEF2;
            height: 26px;
            width: 234px;
        }
        .auto-style101 {
            font-size: medium;
            font-family: Arial;
            height: 26px;
            width: 234px;
        }
        .auto-style102 {
            font-size: medium;
            font-family: Arial;
            background-color: #EEEEF2;
            width: 234px;
        }
        .auto-style103 {
            font-size: medium;
            font-family: Arial;
            width: 234px;
        }
        .auto-style104 {
            font-size: medium;
            text-align: center;
            background-color: #CFD6E5;
            width: 282px;
        }
        .auto-style105 {
            font-size: medium;
            width: 282px;
        }
        .auto-style106 {
            font-size: medium;
            font-family: Arial;
            height: 26px;
            width: 282px;
        }
        .auto-style107 {
            font-size: medium;
            font-family: Arial;
            background-color: #EEEEF2;
            width: 282px;
        }
        .auto-style108 {
            font-size: medium;
            font-family: Arial;
            width: 282px;
        }
        .auto-style109 {
            font-size: medium;
            font-family: Arial;
            background-color: #CFD6E5;
            width: 282px;
        }
        .auto-style110 {
            width: 343px;
        }
        .auto-style111 {
            font-size: x-small;
        }
        .auto-style112 {
            font-size: small;
            width: 21px;
        }
        .auto-style113 {
            font-size: small;
            font-family: Arial;
        }
        .auto-style114 {
            font-size: small;
            height: 26px;
            width: 396px;
            font-family: Arial;
        }
        .auto-style115 {
            border-style: solid;
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <div class="auto-style31">
            <span class="auto-style2"><strong><span class="auto-style60">Travel Compensatory Time Calculator</span><span class="auto-style32"><br />
            </span>
            <table class="auto-style115">
                <tr>
                    <td class="auto-style63" colspan="3"><strong>TRAVEL TO A TEMPORARY DUTY STATION</strong></td>
                </tr>
                <tr>
                    <td class="auto-style95">DEPARTURE FROM:</td>
                    <td class="auto-style86"><input id="txt4" href = "#" data-placement="bottom" tabindex="1" title = "Please use hh:mm format." class="auto-style110"></td>
                    <td class="auto-style51"></td>
                </tr>
                <tr>
                    <td class="auto-style96">&nbsp;</td>
                    <td class="auto-style113" colspan="2">
                        <strong>
                    <input type="radio" name="rbBefore" value="01:30" class="auto-style21" checked="checked" /><span class="auto-style21"> Domesric&nbsp; </span>
                    <input type="radio" name="rbBefore" value="02:00" class="auto-style21" /><span class="auto-style21">International&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
                    <input type="radio" name="rbStatus" value="15" checked="checked" class="auto-style21" title="US" /> US
                    <input type="radio" name="rbStatus" value="60" class="auto-style112" title="FSN" /> FSN</strong></td>
                </tr>
                <tr>
            <span class="auto-style2"><strong>
                    <td class="auto-style97">DAY/DATE OF DEPARTURE:</td>
            </strong></span>
                    <td class="auto-style87">
                        <strong><input id="txt5" href = "#" data-placement="bottom" tabindex="2"  title = "Please use hh:mm format." class="auto-style49"></strong></td>
                    <td class="auto-style21">&nbsp;</td>
                </tr>
                <tr>
            <span class="auto-style2"><strong>
                    <td class="auto-style95">REGULAR TOUR OF DUTY:</td>
            </strong></span>
                    <td class="auto-style114">
                        <strong><input id="txt6" href = "#" data-placement="bottom" tabindex="3"  title = "Please use hh:mm format." class="auto-style49" aria-expanded="true"></strong></td>
                    <td class="auto-style51"></td>
                </tr>
                <tr>
            <span class="auto-style2"><strong>
                    <td class="auto-style97">REGULAR WORKING HOURS:</td>
            </strong></span>
                    <td class="auto-style87">
                        <strong><input id="txt7" href = "#" data-placement="bottom"  tabindex="4" title = "Please use hh:mm format." class="auto-style49"></strong></td>
                    <td class="auto-style21">&nbsp;</td>
                </tr>
            </table>
            </strong>
            <table class="auto-style68">
                <tr>
                    <td class="auto-style85"><strong>CIRCUMSTANCES</strong></td>
                    <td class="auto-style98"><strong>TRAVEL HOURS
                        <br />
                        </strong><span class="auto-style111">in HH:MM format
                        <br />
                        (OUTSIDE OF REGULAR 
                        <br />
                        WORKING HOURS ONLY)</span></td>
                    <td class="auto-style104"><strong>QUALIFIED 
                        <br />
                        HOURS</strong></td>
                </tr>
                <tr>
                    <td class="auto-style83">Drive to Transportation Terminal or TDY worksite (Qualified hours only if there is a need timewise to drive from WORKSITE, not home, outside of normal working hours)</td>
                    <td class="auto-style99"><input id="t1" href = "#" data-placement="bottom"  tabindex="5"title = "Please use hh:mm format." value="0:00"></td>
                    <td class="auto-style105">
                    <asp:Label ID="lblT1" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style75">Usual Waiting Time before the flight (for air travel only) -- Domestic up to 1.5 hours -- International up to 2 hours</td>
                    <td class="auto-style100">
                        <input id="t2" href = "#" data-placement="bottom"  tabindex="6" value="0:00" ></td>
                    <td class="auto-style76">
                    <asp:Label ID="lblT2" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style84">Flight time 1st leg of flight (or train ride)</td>
                    <td class="auto-style101">
                        <input id="t3" href = "#" data-placement="bottom"  tabindex="7" value="0:00"></td>
                    <td class="auto-style106">
                    <asp:Label ID="lblT3" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style75">Usual Waiting Time for connecting flights -- Not more than 2 hours</td>
                    <td class="auto-style100">
                        <input id="t4" href = "#" data-placement="bottom"  tabindex="8" value="0:00"></td>
                    <td class="auto-style76">
                    <asp:Label ID="lblT4" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style84">Flight time 2nd leg of flight (if any)</td>
                    <td class="auto-style101">
                        <input id="t5" href = "#" data-placement="bottom"  tabindex="9" value="0:00"></td>
                    <td class="auto-style106">
                    <asp:Label ID="lblT5" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style82">Usual Waiting Time for connecting flights -- Not more than 2 hours</td>
                    <td class="auto-style102">
                        <input id="t6" href = "#" data-placement="bottom"  tabindex="10" value="0:00"></td>
                    <td class="auto-style107">
                    <asp:Label ID="lblT6" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style83">Flight time 3rd leg of flight (if any)</td>
                    <td class="auto-style103">
                        <input id="t7" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="11" value="0:00"></td>
                    <td class="auto-style108">
                    <asp:Label ID="lblT7" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style82">Drive from Transportation Terminal to hotel or TDY site</td>
                    <td class="auto-style102">
                        <input id="t8" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="12" value="0:00"></td>
                    <td class="auto-style107">
                    <asp:Label ID="lblT8" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style81"><strong class="auto-style80">Total creditable compensatory time off for travel: </strong>
                        <br />
                        Will be rounded to nearest hour for FSN PSCs and nearest 1/4 hr for USPCS and USDH for T&amp;A reporting</td>
                    <td class="auto-style64">&nbsp;</td>
                    <td class="auto-style109">
                    <asp:Label ID="lblTotal1" href = "#" runat="server" CssClass="auto-style72"></asp:Label>
                    </td>
                </tr>
            </table>
            </span>
            <span class="auto-style61">*When an employee&#39;s travel involves two or more time zones, the time zone from point of first departure must be used to determine how many hours the employee actually spent in a travel status.</span><br />
            <table class="auto-style45">
                <tr>
                    <td class="auto-style77">&nbsp;</td>
                    <td class="auto-style77">&nbsp;</td>
                    <td class="auto-style77">
                        <input id="btnCalc" type="button" value="Calculate" /></td>
                </tr>
            </table>
            <br />
            <span class="auto-style2"><strong>
            <table class="auto-style115">
                <tr>
                    <td class="auto-style63" colspan="3"><strong>TRAVEL FROM A TEMPORARY DUTY STATION</strong></td>
                </tr>
                <tr>
                    <td class="auto-style50">RETURNING FROM:</td>
                    <td class="auto-style51"><input id="txt15" href = "#" data-placement="bottom"  tabindex="13" title = "Please use hh:mm format." class="auto-style110"></td>
                    <td class="auto-style51"></td>
                </tr>
                <tr>
                    <td class="auto-style48">&nbsp;</td>
                    <td class="auto-style113">
                        <strong>
                    <input type="radio" name="rbBefore2" value="01:30" class="auto-style21" checked="checked" /><span class="auto-style21"> Domesric&nbsp; </span>
                    <input type="radio" name="rbBefore2" value="02:00" class="auto-style21" /><span class="auto-style21">International</span></strong></td>
                    <td class="auto-style21">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style46">DAY/DATE OF DEPARTURE:</td>
                    <td class="auto-style113">
                        <strong><input id="txt16" href = "#" data-placement="bottom"  tabindex="14" title = "Please use hh:mm format." class="auto-style49"></strong></td>
                    <td class="auto-style21">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style46">REGULAR TOUR OF DUTY:</td>
                    <td class="auto-style113">
                        <strong><input id="txt17" href = "#" data-placement="bottom" tabindex="15" title = "Please use hh:mm format." class="auto-style53" ></strong></td>
                    <td class="auto-style21">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style46">REGULAR WORKING HOURS:</td>
                    <td class="auto-style113">
                        <strong><input id="txtWH" href = "#" data-placement="bottom"  tabindex="16" title = "Please use hh:mm format." class="auto-style49"></strong></td>
                    <td class="auto-style21">&nbsp;</td>
                </tr>
            </table>
            </strong>
            <table class="auto-style115">
                <tr>
                    <td class="auto-style71"><strong>CIRCUMSTANCES</strong></td>
                    <td class="auto-style89"><strong>TRAVEL HOURS
                        <br />
                        </strong><span class="auto-style111">in HH:MM format
                        <br />
                        (OUTSIDE OF REGULAR 
                        <br />
                        WORKING
                        HOURS ONLY)</span></td>
                    <td class="auto-style67"><strong>QUALIFIED<br />
&nbsp;HOURS</strong></td>
                </tr>
                <tr>
                    <td class="auto-style56">Drive to Transportation Terminal or TDY worksite (Qualified hours only if there is a need timewise to drive from WORKSITE, not home, outside of normal working hours)</td>
                    <td class="auto-style90"><input id="t11" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="17" value="0:00"></td>
                    <td class="auto-style55">
                    <asp:Label ID="lblT11" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style65">Usual Waiting Time before the flight (for air travel only) -- Domestic up to 1.5 hours -- International up to 2 hours</td>
                    <td class="auto-style91">
                        <input id="t12" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="18" value="0:00"></td>
                    <td class="auto-style66">
                    <asp:Label ID="lblT12" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style73">Flight time 1st leg of flight (or train ride)</td>
                    <td class="auto-style92">
                        <input id="t13" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="19" value="0:00"></td>
                    <td class="auto-style74">
                    <asp:Label ID="lblT13" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style65">Usual Waiting Time for connecting flights -- Not more than 2 hours</td>
                    <td class="auto-style91">
                        <input id="t14" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="20" value="0:00"></td>
                    <td class="auto-style66">
                    <asp:Label ID="lblT14" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style56">Flight time 2nd leg of flight (if any)</td>
                    <td class="auto-style93">
                        <input id="t15" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="21" value="0:00"></td>
                    <td class="auto-style69">
                    <asp:Label ID="lblT15" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style65">Usual Waiting Time for connecting flights -- Not more than 2 hours</td>
                    <td class="auto-style91">
                        <input id="t16" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="22" value="0:00"></td>
                    <td class="auto-style66">
                    <asp:Label ID="lblT16" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style56">Flight time 3rd leg of flight (if any)</td>
                    <td class="auto-style93">
                        <input id="t17" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="23" value="0:00"></td>
                    <td class="auto-style69">
                    <asp:Label ID="lblT17" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style65">Drive from Transportation Terminal to hotel or TDY site</td>
                    <td class="auto-style91">
                        <input id="t18" href = "#" data-placement="bottom" title = "Please use hh:mm format." tabindex="24" value="0:00"></td>
                    <td class="auto-style66">
                    <asp:Label ID="lblT18" href = "#" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style88"><strong class="auto-style80">Total creditable compensatory time off for travel: </strong>
                        <br />
                        Will be rounded to nearest hour for FSN PSCs and nearest 1/4 hr for USPCS and USDH for T&amp;A reporting</td>
                    <td class="auto-style94">&nbsp;</td>
                    <td class="auto-style70">
                        <strong>
                    <asp:Label ID="lblTotal2" href = "#" runat="server"></asp:Label>
                        </strong>
                    </td>
                </tr>
            </table>
            </span><span class="auto-style62">*When an employee&#39;s travel involves two or more time zones, the time zone from point of first departure must be used to determine how many hours the employee actually spent in a travel status.</span><table class="auto-style45">
                <tr>
                    <td class="auto-style77">&nbsp;</td>
                    <td class="auto-style77">&nbsp;</td>
                    <td class="auto-style77">
                        <input id="btnCalc0" type="button" value="Calculate" /></td>
                </tr>
            </table>
            <table class="auto-style45">
                <tr>
                    <td class="auto-style77">
                        &nbsp;</td>
                    <td class="auto-style78">
                        <asp:Button ID="btnPrint" runat="server" Text="Print" />
                    </td>
                    <td class="auto-style77">
                        <input id="btnClose" type="button" value="Close" 
                            />
                    </td>
                </tr>
            </table>
        </div>
    
    </div>
    </form>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
</body>
</html>
