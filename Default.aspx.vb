



Partial Class _Default
    Inherits System.Web.UI.Page

    Public Const newprojlink As String = "<a href=Default.aspx>Start a New Project</a>"

    Public Sub updateProj()

        Dim mnameconv As mailingNameConverter = New mailingNameConverter

        ' **** 1) client abbr
        Dim cabbr As String = mnameconv.findClientAbbr(drpClient.SelectedValue)

        ' **** 2) date
        Dim mmyyyy = mnameconv.convert_date_into_MMYYYY(txtProjEndDate.Text)


        ' add in a build mailingnamefunction in converter


        ' **** 3) keyword
        Dim mailingkeyword As String = "none"
        If LCase(Trim(rdoKeywordChoose.SelectedValue)) = "custom" Then
            mailingkeyword = txtBoxKeyword.Text
        ElseIf LCase(Trim(rdoKeywordChoose.SelectedValue)) = "promo" Then
            mailingkeyword = "p-" & txtBoxKeyword.Text
        ElseIf rdoKeywordChoose.SelectedValue = "Choose Category" Then

            If rdoKeyword.SelectedIndex <> -1 Then

                mailingkeyword = mnameconv.findParseString(rdoKeyword.SelectedItem.Value)
            End If
        End If

        ' **** 4) job id and type
        Dim projTypeCode As String = ""
        If rdo_ProjType.SelectedValue = "" Then
            projTypeCode = ""
        Else
            projTypeCode = mnameconv.findProjTypeCode(rdo_ProjType.SelectedValue)

        End If
           

            ' **** 5) proj Type Misc
            Dim projTypeMisc As String = ""
            If Len(Trim(txtProjMisc.Text)) > 0 Then
                projTypeMisc = "-" & txtProjMisc.Text
            End If

        Dim ds As DirectoryStructure = New DirectoryStructure
        lbl_projKeyword.Text = mailingkeyword

        lblProjName.Text = cabbr & "_" & mmyyyy & "_" & mailingkeyword & projTypeMisc & "_" & projTypeCode & txtJobID.Text

        If projTypeCode <> "" And Len(drpClient.SelectedItem.Value) > 0 And Len(lblProjName.Text) > 0 Then
           ' lblProjDir.Text = Replace(ds.getProjPath(drpClient.SelectedItem.Value, rdo_ProjType.SelectedItem.Value, lblProjName.Text), DirectoryStructure.dirRoot, "\\marketingdb\")
            lblProjDir.Text = ds.getProjPath(drpClient.SelectedItem.Value, rdo_ProjType.SelectedItem.Value, lblProjName.Text)


            lblProjDirWeb.Text = "n/a"
            'lblProjDirWeb.Text = Replace("http://marketingdb/dirstruct/dev/" & Mid(ds.getProjPath(drpClient.SelectedItem.Value, rdo_ProjType.SelectedItem.Value, lblProjName.Text), Len("c:\data\dirstruct\") + 1), "\", "/")
        End If
        'sqlD_clientsABR.FilterExpression = ""
        'cABBR = drpClient.SelectedValue



        ' add in later ---   newproject.projX_descs

    End Sub

    Public Sub insert_project()
        

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub chkCommonClient_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkCommonClient.CheckedChanged
        drpClient.Enabled = CType(Not chkCommonClient.Checked, Boolean)
        updateProj()
    End Sub


    Protected Sub txtProjEndDate_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtProjEndDate.TextChanged
        updateProj()
    End Sub

    Protected Sub drpClient_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpClient.SelectedIndexChanged
        



        updateProj()
    End Sub



    Protected Sub txtJobID_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtJobID.TextChanged
        updateProj()
    End Sub

    Protected Sub txtProjMisc_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtProjMisc.TextChanged
        updateProj()
    End Sub

    


    Protected Sub rdoKeywordChoose_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdoKeywordChoose.SelectedIndexChanged
        updateProj()
        btn_projKeywordChange.Visible = True
        If LCase(Trim(rdoKeywordChoose.SelectedValue)) = "custom" Then
            txtBoxKeyword.Visible = True
            lbl_chooseKey.Text = "Please type in a custom name: "
            TextBox1_TextBoxWatermarkExtender.WatermarkText = "Type in a custom project name"
            rdoKeyword.Visible = False
        ElseIf LCase(Trim(rdoKeywordChoose.SelectedValue)) = "promo" Then
            txtBoxKeyword.Visible = True
            rdoKeyword.Visible = False
            lbl_chooseKey.Text = "Please type in a promo name: "
            TextBox1_TextBoxWatermarkExtender.WatermarkText = "Type in a promo name"
        ElseIf rdoKeywordChoose.SelectedValue = "Choose Category" Then
            txtBoxKeyword.Visible = False
            lbl_chooseKey.Text = "Please select a Category: "
            rdoKeyword.Visible = True
        End If
    End Sub

    Protected Sub rdoKeyword_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdoKeyword.SelectedIndexChanged
        updateProj()
        rdoKeyword.Visible = False
        btn_projKeywordChange.Visible = True
    End Sub

    Protected Sub txtBoxKeyword_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBoxKeyword.TextChanged
        updateProj()
        txtBoxKeyword.Visible = False
    End Sub

    Protected Sub rdo_ProjType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdo_ProjType.SelectedIndexChanged
        updateProj()
    End Sub

    Protected Sub btn_projKeywordChange_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_projKeywordChange.Click
        If LCase(Trim(rdoKeywordChoose.SelectedValue)) = "choose category" Then
            txtBoxKeyword.Visible = False
            rdoKeyword.Visible = True
        Else
            txtBoxKeyword.Visible = True
            rdoKeyword.Visible = False
        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim pdir As DirectoryStructure = New DirectoryStructure
        If chkCommonClient.Checked = False And chk_create_directories.Checked = True Then

            pdir.createProjDirectory(drpClient.SelectedItem.Text, drpClient.SelectedItem.Value, rdo_ProjType.SelectedValue, lblProjName.Text)
            lblComplete.Visible = True
            Panel1.BorderColor = Drawing.Color.Red
            Panel1.BorderWidth = "2"
            Panel2.Visible = False
            UpdatePanel2.Visible = False
            UpdatePanel3.Visible = False
            UpdatePanel4.Visible = False
            UpdatePanel5.Visible = False
            Button1.Visible = False
            'Panel1.Visible = True
        End If

        Dim projTypeCode As String = ""
        If rdo_ProjType.SelectedValue = "" Then
            projTypeCode = ""
        Else
            projTypeCode = rdo_ProjType.SelectedValue

        End If

        Dim projXdc As projXDataContext = New projXDataContext
        Dim newproject = New projX
        newproject.cid_email = drpClient.SelectedValue
        newproject.jobidQB = txtJobID.Text
        newproject.projname = lblProjName.Text
        newproject.projtypeid = rdo_ProjType.SelectedValue
        newproject.projStartDate = Now
        newproject.projReleaseDate = txtProjEndDate.Text
        newproject.projdir = lblProjDir.Text
        newproject.projstatusid = 1
        newproject.listsegments = drp_list_segment.SelectedItem.Value
        newproject.listoptions = txt_list_options.Text
        newproject.owner = Request.ServerVariables("LOGON_USER")
        newproject.projmisc = txtProjMisc.Text

        If LCase(Trim(rdoKeywordChoose.SelectedValue)) = "custom" Then

        ElseIf LCase(Trim(rdoKeywordChoose.SelectedValue)) = "promo" Then
            newproject.granid = 4
        ElseIf rdoKeywordChoose.SelectedValue = "Choose Category" Then

            If rdoKeyword.SelectedIndex <> -1 Then

                newproject.granid = rdoKeyword.SelectedItem.Value
            End If
        End If


        projXdc.projXes.InsertOnSubmit(newproject)
        projXdc.SubmitChanges()
        Dim pLog = New projx_action
        pLog.actionid = 1
        pLog.timestamp = Now
        pLog.projid = newproject.projid

 


        projXdc.projx_actions.InsertOnSubmit(pLog)
        projXdc.SubmitChanges()


        If chk_list_segment.Checked = True Then
            For i As Integer = 1 To drp_list_segment.SelectedItem.Value
                Dim segment = New ProjX_segment
                segment.projid = newproject.projid

                Dim c As Control
                Dim curr_txt As TextBox = New TextBox
                curr_txt.Text = ""
                Dim curr_opt As TextBox = New TextBox
                curr_opt.Text = ""

                For Each c In ph_list_segments.Controls


                    If c.ID = "txt_seg" & i Then
                        curr_txt = c
                    End If
                    If c.ID = "txt_segopt" & i Then
                        curr_opt = c
                    End If


                Next
                segment.segmentname = curr_txt.Text
                segment.segmentoptions = curr_opt.Text

                '  segment.segmentname = ph_list_segments.Controls.
            Next
            
        End If
        
		End Sub


    Protected Sub drp_list_segment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drp_list_segment.SelectedIndexChanged
        ph_list_segments.Controls.Clear()
        For i As Integer = 1 To drp_list_segment.SelectedItem.Value

            Dim l1 As New Label
            l1.Text = "Segment " & i & " name: "
            ph_list_segments.Controls.Add(l1)

            Dim t As TextBox = New TextBox
            t.ID = "txt_seg" & i
            t.Text = "segment " & i & " name"
            ph_list_segments.Controls.Add(t)

            Dim spacer As LiteralControl = New LiteralControl("   Options:  ")
            ph_list_segments.Controls.Add(spacer)


            t = New TextBox
            t.ID = "txt_segopt" & i
            t.Text = ""
            ph_list_segments.Controls.Add(t)

            spacer = New LiteralControl("<br />")
            ph_list_segments.Controls.Add(spacer)


        Next

    End Sub

    Protected Sub chk_list_segment_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chk_list_segment.CheckedChanged
        If chk_list_segment.Checked Then
            drp_list_segment.Enabled = True
        Else
            drp_list_segment.Enabled = False
        End If
    End Sub
End Class
