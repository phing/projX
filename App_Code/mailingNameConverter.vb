Public Class mailingNameConverter
    Private strconv As String
    Public clientname As String
    Public clientcode As String
    Public cid As String
    Public cid_email As Integer
    Public pid As String
    Public lang As String


    Public parseid As Integer
    Public graniddesc As String
    Public granid As Integer
    Public groupid As Integer
    Public groupdesc As String

    Private clientDB As mailingtypesDataContext

    Public Sub New()
        Call Me.New("")
    End Sub


    Public Sub New(ByVal str As String)
        Me.clientDB = New mailingtypesDataContext
        Me.strconv = str.ToString
        If InStr(Me.strconv, "_") = 0 Then
            Me.lang = "ENG"
            Me.granid = -2  ' made up
            Me.graniddesc = "DeleteMe - Bad Email missing _ "
            Me.groupid = -2
            Me.groupdesc = "DeleteMe - Bad Email missing _ "
            Me.cid = 0
            Me.clientcode = "unk"
            Me.cid_email = 13
        Else
            getclientnameNcid()

            getemailtype()
            getGroup(Me.granid)
            getlang()
        End If

    End Sub


    Private Sub getlang()
        If InStr(LCase(Me.strconv), "_esp") > 0 Then
            Me.lang = "ESP"
        Else
            Me.lang = "ENG"
        End If
    End Sub


    Public Sub getGroup(ByVal granid As Integer)

        Dim grp = From mtgg In clientDB.mailingtype_group_grans Join mtg In clientDB.mailingtype_group_types On mtg.groupid Equals mtgg.groupid _
                  Join gran In clientDB.mailingtype_grans On gran.granid Equals mtgg.granid _
                  Where gran.granid = granid _
                 Select New With {.grandesc = gran.desc, .groupid = mtg.groupid, .groupdesc = mtg.desc, .groupcolor = mtg.color}
        Try
            If grp.Count = 0 Then
                Me.groupdesc = "nothing found for granid " & granid
                Me.groupid = -1
            Else
                Me.groupdesc = grp.First.groupdesc
                Me.groupid = grp.First.groupid
            End If
        Catch e As Exception
            Me.groupid = -1
            Me.groupdesc = "error in SQL for granid " & granid
        End Try

    End Sub


    Private Sub getemailtype()

        'Me.strconv
        Dim mailingt = (From recs In clientDB.mailingtype_parses _
                        Join granrec In clientDB.mailingtype_grans On granrec.granid Equals recs.granid _
                        Order By recs.precedence Descending _
                               Select recs.precedence, recs.parsename, recs.parseid, recs.granid, granrec.desc)
        Dim fc = mailingt.Count

        Dim found = False
        For Each mname In mailingt

            ' there are 3 types of keywords (well a keyword ending in a character)

            ' keywords may end in " " "-" and "_"
            Dim key1 As String = "_" & mname.parsename & "_"
            Dim key2 As String = "_" & mname.parsename & "-"
            Dim key3 As String = "_" & mname.parsename & " "
            Dim key4 As String = "_" & mname.parsename
            Dim found_key1 As Integer = InStr(LCase(Me.strconv), key1)
            Dim found_key2 As Integer = InStr(LCase(Me.strconv), key2)
            Dim found_key3 As Integer = InStr(LCase(Me.strconv), key3)
            Dim found_key4 As Integer = InStr(LCase(Me.strconv), key4)



            If Not found And ((found_key1 > 0) Or (found_key2 > 0) Or (found_key3 > 0) Or (found_key4 > 0)) Then
                found = True
                Me.granid = mname.granid
                Me.graniddesc = mname.desc
                Me.parseid = mname.parseid
                Exit For
            End If
        Next
        If Not found Then
            Me.granid = 23
            Me.graniddesc = "Unknown"
        End If
    End Sub


    Private Sub getclientnameNcid()

        ' parse out the client ABBR for 0 to the first _
        
        Dim tclientname = Mid(Me.strconv, 1, InStr(Me.strconv, "_") - 1)


        ' now set the client n cid
        setclientnameNcid(tclientname)



        If Me.clientcode = "unk" Then
            ' try to get client name somehow
            Dim client_abbrs = (From recs In clientDB.clients_abbrs, cl In clientDB.clients _
                               Where cl.cid_email = recs.cid_email And cl.cid <> 0 _
                               Select cl.cid, cl.cid_email, cl.clientname, recs.abbr)

            For Each abbr In client_abbrs
                If InStr(LCase(Me.strconv), abbr.abbr) > 0 Then
                    Me.clientcode = abbr.abbr

                End If
            Next
            setclientnameNcid(Me.clientcode)
        End If
    End Sub

    Public Function findProjTypeCode(ByVal projtypeid As Integer) As String
        Dim pstrings = From arec In clientDB.project_types Where arec.projtypeid = projtypeid _
                       Select arec.projtype_code

        Try
            If pstrings.Count = 0 Then
                Return "notype"
            Else
                Return pstrings.First.ToString
            End If
        Catch
            Return "errortype"
        End Try
    End Function


    Public Function findParseString(ByVal granid As Integer) As String
        Dim pstrings = From arec In clientDB.mailingtype_parses Where arec.granid = granid _
                       Select arec.parsename

        Try
            If pstrings.Count = 0 Then
                Return "noparse"
            Else
                Return pstrings.First.ToString
            End If
        Catch
            Return "errorparse"
        End Try
    End Function

    Public Function convert_date_into_MMYYYY(ByVal d As String) As String
        If d = "" Or Len(d) < 1 Then
            Return "000000"
        End If
        Try
            Dim theDate As Date = Convert.ToDateTime(d)
            Dim m As String
            If Month(d) < 10 Then
                m = "0" & Month(d)
            Else
                m = Month(d)
            End If
            Return m & Year(d)
        Catch ex As Exception
            Return "000000"
        End Try
    End Function

    Public Function findClientAbbr(ByVal cid_email As Integer) As String
        'Dim db As mailingtypesDataContext = New mailingtypesDataContext
        Dim cAbbr = From arec In clientDB.clients_abbrs _
                    Where arec.cid_email = cid_email _
                    Select arec.abbr
        Return cAbbr.First.ToString
    End Function


    Private Sub setclientnameNcid(ByVal name As String)

        Dim parsed_clientname As String = LCase(name)
        Dim foundclientname = (From recs In clientDB.clients_abbrs, cl In clientDB.clients _
                               Where recs.abbr = parsed_clientname And cl.cid_email = recs.cid_email _
                               Select cl.cid, cl.cid_email, cl.clientname, recs.abbr)
        Dim fc = foundclientname.Count

        If fc = 0 Then
            ' no client abbr is found... use unk=13
            Me.clientname = "UNK"
            Me.cid = 0
            Me.clientcode = "unk"
            Me.cid_email = 13
        Else
            Me.clientname = foundclientname.First.clientname
            Me.cid = foundclientname.First.cid
            Me.clientcode = foundclientname.First.abbr
            Me.cid_email = foundclientname.First.cid_email
        End If

    End Sub



End Class
