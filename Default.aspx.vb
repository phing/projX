﻿



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
        newproject.listoptions = txt_listoptions.Text
        newproject.projname = lblProjName.Text
        newproject.projtypeid = rdo_ProjType.SelectedValue
        newproject.projStartDate = Now
        newproject.projReleaseDate = txtProjEndDate.Text
        newproject.projdir = lblProjDir.Text
        newproject.projstatusid = 1
        newproject.projmisc = txtProjMisc.Text
        projXdc.projXes.InsertOnSubmit(newproject)
        projXdc.SubmitChanges()
        Dim pLog = New projx_action
        pLog.actionid = 1
        pLog.timestamp = Now
        pLog.projid = newproject.projid
        projXdc.projx_actions.InsertOnSubmit(pLog)
        projXdc.SubmitChanges()
		End Sub

    Protected Sub btnPdescShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPdescShow.Click
        chkProjDesc.Visible = True
    End Sub

    Protected Sub btnPdescHide_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPdescHide.Click
        chkProjDesc.Visible = False
    End Sub

End Class