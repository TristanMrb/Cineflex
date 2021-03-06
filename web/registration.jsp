<!-- Registrieren Screen-->
<div class="modal fade" id="registerDialog" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="registerDialogTitle">Registrieren</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form name="RegistrationForm" action="registrationHandler.jsp" method="post">
                    <div class="form-group">
                        <label for="inputVorname">Vorname</label>
                        <input type="text" class="form-control" id="inputVorname" name="inputVorname" required="required" pattern="[A-Za-z0-9]{1,}" placeholder="Vorname">
                    </div>
                    <div class="form-group">
                        <label for="inputNachname">Nachname</label>
                        <input type="text" class="form-control" id="inputNachname" name="inputNachname" required="required" pattern="[A-Za-z0-9]{1,}" placeholder="Nachname">
                    </div>
<%--                    <div class="form-group">--%>
<%--                        <label for="inputGeb">Geburtsdatum</label>--%>
<%--                        <input type="text" class="form-control" id="inputGeb" name="inputGeb" required="required" placeholder="YYYY-MM-DD">--%>
<%--                    </div>--%>
                    <div class="form-group">
                        <label for="inputGeb">Geburtsdatum</label>
                        <input type="date" class="form-control" id="inputGeb" name="inputGeb" value="0000-00-00"
                               min="0000-00-00" max="9999-12-31">
                    </div>
                    <div class="form-group">
                        <label for="inputOrt">Wohnort</label>
                        <input type="text" class="form-control" id="inputOrt" name="inputOrt" required="required" placeholder="Wohnort">
                    </div>
                    <div class="form-group">
                        <label for="inputPLZ">Postleitzahl</label>
                        <input type="text" class="form-control" id="inputPLZ" name="inputPLZ" required="required" placeholder="Postleitzahl">
                    </div>
                    <div class="form-group">
                        <label for="inputStr">Stra&szlig;e</label>
                        <input type="text" class="form-control" id="inputStr" name="inputStr" required="required" placeholder="Stra&szlig;e">
                    </div>
                    <div class="form-group">
                        <label for="inputHNr">Hausnummer</label>
                        <input type="text" class="form-control" id="inputHNr" name="inputHNr" required="required" placeholder="Hausnummer">
                    </div>
                    <div class="form-group">
                        <label for="inputAdz">Adresszusatz</label>
                        <input type="text" class="form-control" id="inputAdz" name="inputAdz" placeholder="Adresszusatz">
                    </div>
                    <div class="form-group">
                        <label for="inputEmailReg">E-Mail</label>
                        <input type="email" class="form-control" id="inputEmailReg" name="inputEmailReg" required="required" aria-describedby="emailHelp" placeholder="E-Mail Adresse">
                        <small id="emailHelp" class="form-text text-muted">Wir werden dir eine Verifizierungsmail schicken.</small>
                    </div>
                    <div class="form-group">
                        <label for="inputPasswordReg">Passwort</label>
                        <input type="password" class="form-control" id="inputPasswordReg" name="inputPasswordReg" required="required" placeholder="Passwort">
                    </div>
                    <div class="form-group">
                        <label for="inputPasswordRegWdh">Passwort wiederholen</label>
                        <input type="password" class="form-control" id="inputPasswordRegWdh" name="inputPasswordRegWdh" required="required" placeholder="Passwort">
                    </div>
                    <div class="form-group form-check">
                        <input type="checkbox" class="form-check-input" id="receiveMails">
                        <label class="form-check-label" for="receiveMails">Ich m&#246;chte t&#228;gliche E-Mails zu neuen Angeboten von Multiflex erhalten. Au&#223;erdem bin ich damit einverstanden, dass meine Daten an dritte Verkauft werden.</label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Abbrechen</button>
                <button type="button" onclick="submitRegistration()" class="btn btn-primary">Registrieren</button>
            </div>
        </div>
    </div>
</div>
<script>
    var input = document.getElementById("inputPasswordRegWdh");

    // Register if Enter is hit
    input.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            submitRegistration();
        }
    });
</script>