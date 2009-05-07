<%@ Page Language="VB"  MasterPageFile="~/MasterPage.master" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="projXstart" ContentPlaceHolderID="MainContent" runat="Server">







    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    

    
       
        
        
     
         <span lang="en-us">This project is currently in Beta Testing and should be 
		used carefully and everything should be verified if you use it.<br />
    <br />
    </span>
    

   
        
     
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
        
          <asp:Panel ID="pnl_projecttype" runat="server" CssClass="squareboxgradientcaption"  >
                <asp:Image ID="img_projecttype" runat="server" />  
               <b>Project Type :  </b>
                <asp:Label runat="server" ID="lbl_projecttype"></asp:Label>
          </asp:Panel>
          
          <cc1:CollapsiblePanelExtender 
                ID="CollapsiblePanelExtender2"
                TargetControlID="pnl_projecttype_collapse"
                
                Collapsed="true" 

                ExpandControlID="img_projecttype"
                CollapseControlID="img_projecttype"
                TextLabelID="lbl_projecttype"
                ImageControlID="img_projecttype"
                
                runat="server"
                CollapsedSize="0"                
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="false"
                CollapsedText="Show Details..."
                ExpandedText="Hide Details" 
                ExpandedImage="~/images/collapse.jpg"
                CollapsedImage="~/images/expand.jpg"
                ExpandDirection="Vertical" />
          </cc1:CollapsiblePanelExtender>
          
        
        
        <asp:Panel ID="pnl_projecttype_collapse" runat="server" CssClass="squarebox"> 
        
        <div class="squareboxcontent">
        
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
                                runat="server"  TargetControlID="txtBoxKeyword">
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
  
        
     
        
        
     </div>   
    </asp:Panel>
    
    
    
    
     <br />
     <asp:Panel ID="pnl_projdesc" runat="server" CssClass="squareboxgradientcaption"  >
                <asp:Image ID="img_projdesc" runat="server" />  
                <b>Project Descriptors:&nbsp;</b> 
                <asp:Label runat="server" ID="lbl_projdesc"></asp:Label>
          </asp:Panel>
          
          <cc1:CollapsiblePanelExtender 
                ID="CollapsiblePanelExtender3"
                TargetControlID="pnl_projdesc_collapse"
                
                Collapsed="false" 

                ExpandControlID="img_projdesc"
                CollapseControlID="img_projdesc"
                TextLabelID="lbl_projdesc"
                ImageControlID="img_projdesc"
                
                runat="server"
                CollapsedSize="0"                
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="false"
                CollapsedText="Show Details..."
                ExpandedText="Hide Details" 
                ExpandedImage="~/images/collapse.jpg"
                CollapsedImage="~/images/expand.jpg"
                ExpandDirection="Vertical" />
          </cc1:CollapsiblePanelExtender>
        
        
        <asp:Panel ID="pnl_projdesc_collapse" runat="server" CssClass="squarebox">
        <div class="squareboxcontent">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
               <ContentTemplate>
     
     
        
               
        <asp:CheckBoxList ID="chkProjDesc" runat="server" 
            DataSourceID="sqlProjDesc" DataTextField="desc" DataValueField="descid" 
                Visible="true" CellPadding="2" CellSpacing="2" DataMember="DefaultView" 
                RepeatColumns="7">
        </asp:CheckBoxList>
    
       
         </ContentTemplate>
         </asp:UpdatePanel>
         </div>
         
         </asp:Panel>
       
       
       
        <br />
          <asp:Panel ID="pnl_projdetails" runat="server" CssClass="squareboxgradientcaption"  >
                <asp:Image ID="img_projdetails" runat="server" />  
                <b> Project Details  :  </b>
                <asp:Label runat="server" ID="lbl_projdetails"></asp:Label>
          </asp:Panel>
          
          <cc1:CollapsiblePanelExtender 
                ID="CollapsiblePanelExtender4"
                TargetControlID="pnl_listoptions_collapse"
                
                Collapsed="false" 

                ExpandControlID="img_projdetails"
                CollapseControlID="img_projdetails"
                TextLabelID="lbl_projdetails"
                ImageControlID="img_projdetails"
                
                runat="server"
                CollapsedSize="0"                
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="false"
                CollapsedText="Show Details..."
                ExpandedText="Hide Details" 
                ExpandedImage="~/images/collapse.jpg"
                CollapsedImage="~/images/expand.jpg"
                ExpandDirection="Vertical" />
          </cc1:CollapsiblePanelExtender>
        
        
        <asp:Panel ID="pnl_projdetails_collapse" runat="server" CssClass="squarebox">
        <div class="squareboxcontent">
        
        
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
                        &nbsp;</td>
                </tr>
            </caption>
            
            </table>
        </td>
        </tr>
        </table>
        <br />
              </ContentTemplate>
            </asp:UpdatePanel>
        
        </div>
        
        </asp:Panel>
        
          <asp:Panel ID="pnl_listoptions" runat="server" CssClass="squareboxgradientcaption"  >
                <asp:Image ID="img_listoptions" runat="server" />  
                List Options :  
                <asp:Label runat="server" ID="lbl_listoptions"></asp:Label>
          </asp:Panel>
          
          <cc1:CollapsiblePanelExtender 
                ID="CollapsiblePanelExtender1"
                TargetControlID="pnl_listoptions_collapse"
                
                Collapsed="false" 

                ExpandControlID="img_listoptions"
                CollapseControlID="img_listoptions"
                TextLabelID="lbl_listoptions"
                ImageControlID="img_listoptions"
                
                runat="server"
                CollapsedSize="0"                
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="false"
                CollapsedText="Show Details..."
                ExpandedText="Hide Details" 
                ExpandedImage="~/images/collapse.jpg"
                CollapsedImage="~/images/expand.jpg"
                ExpandDirection="Vertical" />
          </cc1:CollapsiblePanelExtender>
        
        
        <asp:Panel ID="pnl_listoptions_collapse" runat="server" CssClass="squarebox">
        <div class="squareboxcontent">
        <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Always">
               <ContentTemplate>
          
&nbsp;<table width="800px">
            <tr>
            <td class="style6">

                    Special List Options:
                </td>
                <td>
                <asp:TextBox ID="txt_list_options" Text="" runat="server" Height="55px" 
                        Width="174px"></asp:TextBox>
                </td></tr><tr>
                <td class="style6">
                    Segment:
                </td>
                <td>
                    <asp:CheckBox ID="chk_list_segment" runat="server" AutoPostBack="True" />
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label ID="lbl_list_segment" runat="server" Text="Number of Segments: "></asp:Label>
                </td>
                <td>
                    <asp:DropDownList Enabled="false" ID="drp_list_segment" runat="server" 
                        AutoPostBack="True" >

                         <asp:ListItem Value="1" Text="1 - No Segments" Selected="true"></asp:ListItem>
                         <asp:ListItem Value="2" Text="2"></asp:ListItem>
                         <asp:ListItem Value="3" Text="3"></asp:ListItem>
                         <asp:ListItem Value="4" Text="4"></asp:ListItem>
                         <asp:ListItem Value="5" Text="5"></asp:ListItem>
                         <asp:ListItem Value="6" Text="6"></asp:ListItem>
                         <asp:ListItem Value="7" Text="7"></asp:ListItem>
                       </asp:DropDownList>
                </td>
            </tr>
          </table>
               
                <asp:PlaceHolder ID="ph_list_segments" runat="server"></asp:PlaceHolder>
           
       
             </ContentTemplate> 
             
             </asp:UpdatePanel>  

           </div>  
        </asp:Panel> 
        <br />
  
        
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
        .style6
        {
            width: 212px;
        }
    </style>

</asp:Content>


