<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="viewprojects.aspx.vb" Inherits="viewprojects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    Current Projects:<br />
    <br />
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
    DataKeyNames="projid" DataSourceID="SqlDataSource1" ForeColor="Black" 
    GridLines="Horizontal">
    <Columns>
        <asp:CommandField ShowDeleteButton="false" ShowEditButton="false" 
            ShowSelectButton="True" />
        <asp:BoundField DataField="projid" HeaderText="projid" InsertVisible="False" 
            ReadOnly="True" SortExpression="projid" />
        <asp:BoundField DataField="projname" HeaderText="projname" 
            SortExpression="projname" />
        <asp:BoundField DataField="projdir" HeaderText="projdir" 
            SortExpression="projdir" />
        <asp:BoundField DataField="projtypeid" HeaderText="projtypeid" 
            SortExpression="projtypeid" />
        <asp:BoundField DataField="projReleaseDate" HeaderText="projReleaseDate" 
            SortExpression="projReleaseDate" />
        <asp:BoundField DataField="projStartDate" HeaderText="projStartDate" 
            SortExpression="projStartDate" />
        <asp:BoundField DataField="cid_email" HeaderText="cid_email" 
            SortExpression="cid_email" />
        <asp:BoundField DataField="jobidQB" HeaderText="jobidQB" 
            SortExpression="jobidQB" />
        <asp:BoundField DataField="projmisc" HeaderText="projmisc" 
            SortExpression="projmisc" />
        <asp:BoundField DataField="listoptions" HeaderText="listoptions" 
            SortExpression="listoptions" />
        <asp:BoundField DataField="projstatusid" HeaderText="projstatusid" 
            SortExpression="projstatusid" />
    </Columns>
    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
    </asp:GridView>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConflictDetection="CompareAllValues" 
    ConnectionString="<%$ ConnectionStrings:email_metricsConnectionString %>" 
    DeleteCommand="DELETE FROM [projX] WHERE [projid] = @original_projid AND (([projname] = @original_projname) OR ([projname] IS NULL AND @original_projname IS NULL)) AND (([projdir] = @original_projdir) OR ([projdir] IS NULL AND @original_projdir IS NULL)) AND (([projtypeid] = @original_projtypeid) OR ([projtypeid] IS NULL AND @original_projtypeid IS NULL)) AND (([projReleaseDate] = @original_projReleaseDate) OR ([projReleaseDate] IS NULL AND @original_projReleaseDate IS NULL)) AND (([projStartDate] = @original_projStartDate) OR ([projStartDate] IS NULL AND @original_projStartDate IS NULL)) AND (([cid_email] = @original_cid_email) OR ([cid_email] IS NULL AND @original_cid_email IS NULL)) AND (([jobidQB] = @original_jobidQB) OR ([jobidQB] IS NULL AND @original_jobidQB IS NULL)) AND (([projmisc] = @original_projmisc) OR ([projmisc] IS NULL AND @original_projmisc IS NULL)) AND (([listoptions] = @original_listoptions) OR ([listoptions] IS NULL AND @original_listoptions IS NULL)) AND (([projstatusid] = @original_projstatusid) OR ([projstatusid] IS NULL AND @original_projstatusid IS NULL))" 
    InsertCommand="INSERT INTO [projX] ([projname], [projdir], [projtypeid], [projReleaseDate], [projStartDate], [cid_email], [jobidQB], [projmisc], [listoptions], [projstatusid]) VALUES (@projname, @projdir, @projtypeid, @projReleaseDate, @projStartDate, @cid_email, @jobidQB, @projmisc, @listoptions, @projstatusid)" 
    OldValuesParameterFormatString="original_{0}" 
    SelectCommand="SELECT * FROM [projX]" 
    UpdateCommand="UPDATE [projX] SET [projname] = @projname, [projdir] = @projdir, [projtypeid] = @projtypeid, [projReleaseDate] = @projReleaseDate, [projStartDate] = @projStartDate, [cid_email] = @cid_email, [jobidQB] = @jobidQB, [projmisc] = @projmisc, [listoptions] = @listoptions, [projstatusid] = @projstatusid WHERE [projid] = @original_projid AND (([projname] = @original_projname) OR ([projname] IS NULL AND @original_projname IS NULL)) AND (([projdir] = @original_projdir) OR ([projdir] IS NULL AND @original_projdir IS NULL)) AND (([projtypeid] = @original_projtypeid) OR ([projtypeid] IS NULL AND @original_projtypeid IS NULL)) AND (([projReleaseDate] = @original_projReleaseDate) OR ([projReleaseDate] IS NULL AND @original_projReleaseDate IS NULL)) AND (([projStartDate] = @original_projStartDate) OR ([projStartDate] IS NULL AND @original_projStartDate IS NULL)) AND (([cid_email] = @original_cid_email) OR ([cid_email] IS NULL AND @original_cid_email IS NULL)) AND (([jobidQB] = @original_jobidQB) OR ([jobidQB] IS NULL AND @original_jobidQB IS NULL)) AND (([projmisc] = @original_projmisc) OR ([projmisc] IS NULL AND @original_projmisc IS NULL)) AND (([listoptions] = @original_listoptions) OR ([listoptions] IS NULL AND @original_listoptions IS NULL)) AND (([projstatusid] = @original_projstatusid) OR ([projstatusid] IS NULL AND @original_projstatusid IS NULL))">
    <DeleteParameters>
        <asp:Parameter Name="original_projid" Type="Int64" />
        <asp:Parameter Name="original_projname" Type="String" />
        <asp:Parameter Name="original_projdir" Type="String" />
        <asp:Parameter Name="original_projtypeid" Type="Int32" />
        <asp:Parameter DbType="Date" Name="original_projReleaseDate" />
        <asp:Parameter DbType="Date" Name="original_projStartDate" />
        <asp:Parameter Name="original_cid_email" Type="Int32" />
        <asp:Parameter Name="original_jobidQB" Type="String" />
        <asp:Parameter Name="original_projmisc" Type="String" />
        <asp:Parameter Name="original_listoptions" Type="String" />
        <asp:Parameter Name="original_projstatusid" Type="Int64" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="projname" Type="String" />
        <asp:Parameter Name="projdir" Type="String" />
        <asp:Parameter Name="projtypeid" Type="Int32" />
        <asp:Parameter DbType="Date" Name="projReleaseDate" />
        <asp:Parameter DbType="Date" Name="projStartDate" />
        <asp:Parameter Name="cid_email" Type="Int32" />
        <asp:Parameter Name="jobidQB" Type="String" />
        <asp:Parameter Name="projmisc" Type="String" />
        <asp:Parameter Name="listoptions" Type="String" />
        <asp:Parameter Name="projstatusid" Type="Int64" />
        <asp:Parameter Name="original_projid" Type="Int64" />
        <asp:Parameter Name="original_projname" Type="String" />
        <asp:Parameter Name="original_projdir" Type="String" />
        <asp:Parameter Name="original_projtypeid" Type="Int32" />
        <asp:Parameter DbType="Date" Name="original_projReleaseDate" />
        <asp:Parameter DbType="Date" Name="original_projStartDate" />
        <asp:Parameter Name="original_cid_email" Type="Int32" />
        <asp:Parameter Name="original_jobidQB" Type="String" />
        <asp:Parameter Name="original_projmisc" Type="String" />
        <asp:Parameter Name="original_listoptions" Type="String" />
        <asp:Parameter Name="original_projstatusid" Type="Int64" />
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="projname" Type="String" />
        <asp:Parameter Name="projdir" Type="String" />
        <asp:Parameter Name="projtypeid" Type="Int32" />
        <asp:Parameter DbType="Date" Name="projReleaseDate" />
        <asp:Parameter DbType="Date" Name="projStartDate" />
        <asp:Parameter Name="cid_email" Type="Int32" />
        <asp:Parameter Name="jobidQB" Type="String" />
        <asp:Parameter Name="projmisc" Type="String" />
        <asp:Parameter Name="listoptions" Type="String" />
        <asp:Parameter Name="projstatusid" Type="Int64" />
    </InsertParameters>
</asp:SqlDataSource>

</asp:Content>

