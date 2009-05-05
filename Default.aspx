<%@ Page Language="VB"  MasterPageFile="~/MasterPage.master" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="projXstart" ContentPlaceHolderID="MainContent" runat="Server">







    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    

    
       
        
        
     
         <span lang="en-us">This project is currently in Beta Testing and should be 
		used carefully and everything should be verified if you use it.<br />
    <br />
    </span>User: <br /> <%=System.Security.Principal.WindowsIdentity.GetCurrent.Name() %>
        <br />
        
     
         <br />
        <asp:Panel ID="Panel1" runat="server">
            <asp:Label Font-Bold="True" ForeColor="Red"  Visible="False" ID="lblComplete" runat="server"
                    Text="Your Directories have been created. -> "> 
                 </asp:Label>
                &nbsp; &nbsp; <% If lblComplete.Visible = True then Response.Write(newprojlink) %>
      
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                <ContentTemplate> 
           
             
                
                <table width="950px"><tr align="left"><td class="style3">
                <asp:Label ID="Label1" runat="server" Text="Current Project Name: "></asp:Label></td>
                <td>
                    <asp:Label ID="lblProjName" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td><tr align="left">
                    <td class="style3">
                <asp:Label ID="Label2" runat="server" Text="Project File Directory: "></asp:Label></td>
                    <td>
                        <asp:Label ID="lblProjDir" runat="server" Text="" style="font-weight: 700"></asp:Label>
                </td><tr align="left">
                        <td class="style3">
                <asp:Label ID="Label3" runat="server" Text="Current Web Location: "></asp:Label></td>
                    <td>
                        <asp:Label ID="lblProjDirWeb" runat="server" style="font-weight: 700" Text=""></asp:Label>
                </td>
            </td>
            </tr>
            </table>
                         

            
             </center>
        <br />
        
        
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>   
        
        
        <hr align="left" class="thin" style="width: 950px" />
        
        
        
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
        
        <br />
        <table>
            <tr>
                <td>
                    <b>Project Type:</b>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;<asp:RadioButtonList ID="rdo_ProjType" runat="server" BorderStyle="Solid" DataSourceID="SqlDataSource1"
                        DataTextField="projtype_desc" DataValueField="projtypeid" RepeatDirection="Horizontal"
                        AutoPostBack="True">
                    </asp:RadioButtonList>
                   
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:email_metricsConnectionString %>"
                        
                        SelectCommand="SELECT projtypeid, projtype_desc, projtype_code, projtype_dir FROM project_types"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
        
        
       
   
          
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="rdo_ProjType"
                    Display="None" ErrorMessage="<b>Required Field Missing</b><br />A Project Type is Required. <br><br> Please select a type from the left." />
                <cc1:ValidatorCalloutExtender runat="Server" ID="ValidatorCalloutExtender2" TargetControlID="RequiredFieldValidator1"
                    HighlightCssClass="highlight" WarningIconImageUrl="images/warning.gif" CloseImageUrl="images/close.gif" />
          
        
 
        <table  border="0" border-color="black" cellpadding="2" width="950px">
            <tr>
                <td valign="top" width="150px">
                    &nbsp;<b>Project Keyword:</b> <span lang="en-us">&nbsp;<br />
                    (choose from following):</span>&nbsp;&nbsp;<br />
                    <asp:RadioButtonList ID="rdoKeywordChoose" runat="server" AutoPostBack="True">
                        <asp:ListItem>Choose Category</asp:ListItem>
                        <asp:ListItem>Promo</asp:ListItem>
                        <asp:ListItem>Custom</asp:ListItem>
                        
                    </asp:RadioButtonList>
                </td>
                <td valign="top">
                    
                            <asp:Label ID="lbl_chooseKey" runat="server"></asp:Label>
                            <asp:Button ID="btn_projKeywordChange" runat="server" CausesValidation="False" 
                                Text="change" Visible="False" Width="50px" />
                            <asp:TextBox ID="lbl_projKeyword" runat="server" BackColor="White" 
                                  Enabled="False" ForeColor="#0000CC" CssClass="txtBoxNone" Height="16px" 
                                Width="164px" Font-Bold="True"></asp:TextBox>
                            <br />
                                
                            <asp:RequiredFieldValidator runat="server" ID="PNReq2" ControlToValidate="lbl_projKeyword"
                                Display="None"  ErrorMessage="<b>Required Field Missing</b><br />A Project Keyword is Required. <br><br> Please select a category or a custom keyword from the left." />
                            <cc1:ValidatorCalloutExtender runat="Server" ID="ValidatorCalloutExtender1" TargetControlID="PNReq2"
                                Width="350px"  HighlightCssClass="highlight" WarningIconImageUrl="images/warning.gif"
                                CloseImageUrl="images/close.gif" />   
                                
                                
                            <br />
                            <asp:TextBox ID="txtBoxKeyword" runat="server" Visible="False" BackColor="#FFFFcc"
                                BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                                Width="200px" Style="margin-bottom: 0px" AutoPostBack="True" 
                                CausesValidation="True"></asp:TextBox>
                            <cc1:TextBoxWatermarkExtender WatermarkText="Type in a Custom Keyword" ID="TextBox1_TextBoxWatermarkExtender"
                                runat="server" TargetControlID="txtBoxKeyword">
                            </cc1:TextBoxWatermarkExtender>
                            <asp:RadioButtonList ID="rdoKeyword" runat="server" AutoPostBack="True" BackColor="#FFFFcc"
                                BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" DataSourceID="mailingtypes"
                                DataTextField="desc" DataValueField="granid"
                                Visible="False" RepeatColumns="4">
                            </asp:RadioButtonList>
                        
                </td>
            </tr>
        </table>
        





            </ContentTemplate>
            
            <Triggers>
                  <asp:AsyncPostBackTrigger ControlID="rdoKeyword"    />
                  <asp:AsyncPostBackTrigger ControlID="txtBoxKeyword" />
                  <asp:AsyncPostBackTrigger ControlID="rdo_ProjType" />
            
            </Triggers>
        </asp:UpdatePanel>
  
        
        
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
         
        <br />
        <b>Project Descriptors:&nbsp;
        <asp:Button ID="btnPdescShow" runat="server" BackColor="White" Text="Show" 
                CausesValidation="False" UseSubmitBehavior="False" />
&nbsp; </b>/         <b>&nbsp;
        <asp:Button ID="btnPdescHide" runat="server" BackColor="White" Text="Hide" 
                CausesValidation="False" UseSubmitBehavior="False" />
        <br />
        </b>
        <asp:CheckBoxList ID="chkProjDesc" runat="server" 
            DataSourceID="sqlProjDesc" DataTextField="desc" DataValueField="descid" 
                Visible="False" CellPadding="2" CellSpacing="2" DataMember="DefaultView" 
                RepeatColumns="5">
        </asp:CheckBoxList>
        </ContentTemplate>
        </asp:UpdatePanel>
        
        <br />
        <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <br />
            <table>
                <tr>
                    <td>
                        <table>
  
            
            <tr>
                <td>
                    Project Release Date:
                </td>
                <td>
                 
                    <asp:TextBox ID="txtProjEndDate" runat="server" AutoPostBack="True"></asp:TextBox>
                    
                    <cc1:CalendarExtender ID="CalendarExtender1" TargetControlID="txtProjEndDate" runat="server">
                    </cc1:CalendarExtender>
                    
                    
                    
                    <asp:RequiredFieldValidator  runat="server" ID="PNReq" ControlToValidate="txtProjEndDate"
                        Display="None" ErrorMessage="<b>Required Field Missing</b><br />A Project date Required." />
                    <cc1:ValidatorCalloutExtender runat="Server" ID="validateDate" TargetControlID="PNReq"
                        Width="350px" HighlightCssClass="highlight" WarningIconImageUrl="images/warning.gif"
                        CloseImageUrl="images/close.gif"  />
                    
                    
                </td>
            </tr>
            <caption>
                <br />
                <tr>
                    <td>
                        Common Client:<span lang="en-us">(disabled)</span>
                    </td>
                    <td>
                        <asp:CheckBox ID="chkCommonClient" runat="server" AutoPostBack="True" Enabled="false" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Client:
                    </td>
                    <td>
                        <asp:DropDownList ID="drpClient" runat="server" DataSourceID="sqlD_clients" DataTextField="clientname"
                            DataValueField="cid_email" Enabled="true" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Job ID:
                    </td>
                    <td>
                        <asp:TextBox ID="txtJobID" runat="server" AutoPostBack="True" Width="50px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ControlToValidate="txtJobID" Display="None" 
                            ErrorMessage="&lt;b&gt;Required Field Missing&lt;/b&gt;&lt;br /&gt;A Numeric Project ID Required." 
                            ValidationExpression="[0-9]+"></asp:RegularExpressionValidator>
                        <cc1:ValidatorCalloutExtender ID="RegularExpressionValidator1_ValidatorCalloutExtender" 
                            runat="server" CloseImageUrl="images/close.gif" Enabled="True" 
                            HighlightCssClass="highlight" TargetControlID="RegularExpressionValidator1" 
                            WarningIconImageUrl="images/warning.gif" Width="350px">
                        </cc1:ValidatorCalloutExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        Project Description:
                    </td>
                    <td>
                        <asp:TextBox ID="txtProjMisc" runat="server" AutoPostBack="True" Width="150px"></asp:TextBox>
                    </td>
                </tr>
               <tr>
                    <td>
                        Create Dev Directories:<span lang="en-us"></span>
                    </td>
                    <td>
                        <asp:CheckBox ID="chk_create_directories" runat="server" AutoPostBack="True" 
                            Enabled="true" Checked="True" />
                    </td>
                </tr>
                <tr>
                    <td>
                        List Options (segment...) :<span lang="en-us"></span>
                    </td>
                    <td>
                        <asp:TextBox ID="txt_listoptions" runat="server" Wrap="true" Width="240px" 
                            Height="70px"></asp:TextBox>
                    </td>
                </tr>
            </caption>
            
            </table>
        </td>
        </tr>
        </table>
        
        <br />
        </ContentTemplate>
            </asp:UpdatePanel>
        
            <asp:Panel ID="Panel2" runat="server">
            
       
        <a href="Default.aspx">Start a New Project</a>
        <br>
    
       
        
        <div class="bottom_button">
            <span class="button">
                <asp:Button ID="Button1" runat="server" Text="build project" Width="113px"  
                  /> </span>
        </div>
         <br />
        </asp:Panel>
        
                <asp:SqlDataSource ID="mailingtypes" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:email_metricsConnectionString %>" 
                    
            
			SelectCommand="SELECT granid, [desc] FROM mailingtype_gran WHERE (granid NOT IN (SELECT granid FROM mailingtype_gran AS mailingtype_gran_1 WHERE (granid = 0) OR (granid = 4))) ORDER BY [desc]">
                </asp:SqlDataSource>
                
          
        
        
        
        <asp:SqlDataSource ID="sqlD_clients" runat="server" 
            ConnectionString="<%$ ConnectionStrings:email_metricsConnectionString %>" 
            
            
            
            SelectCommand="SELECT clientname, cid, cid_email FROM clients WHERE (cid_email &lt;&gt; 2) order by clientname">
        </asp:SqlDataSource>
    
        
        
        <asp:SqlDataSource ID="sqlProjDesc" runat="server" 
            ConnectionString="<%$ ConnectionStrings:email_metricsConnectionString %>" 
            SelectCommand="SELECT [descid], [desc] FROM [mailingtype_desc_types]">
        </asp:SqlDataSource>
    
        
        

    
        
 
    
        
        

    
        
        
        <asp:SqlDataSource ID="sqlD_clientsABR" runat="server" ConnectionString="<%$ ConnectionStrings:email_metricsConnectionString %>"
            SelectCommand="SELECT clients_abbr.* FROM clients_abbr">
        </asp:SqlDataSource>
    
        
        
        <br />




    
    
    


</asp:Content>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">

    <style type="text/css">
        .style2
        {
            width: 362px;
        }
        .style3
        {
            width: 156px;
        }
    </style>

</asp:Content>


