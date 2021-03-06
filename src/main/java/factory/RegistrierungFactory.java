package factory;

import db_connector.Connector;
import db_connector.QueryBuilder;
import exception.EmptyResultSetException;
import exception.RequiredFactoryFailedException;
import exception.ResultSetIsNullException;
import exception.registrierung.EmptyInputValueException;
import exception.registrierung.UnmatchingPasswordException;
import exception.registrierung.UserAlreadyExistsException;
import helper.SupportMethods;
import oo.Registrierung;
import send_mail.Email_Sender;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class RegistrierungFactory {

    /**
     * Creates an entry in the database for a newly registered user
     * @param vorname First name of the new user
     * @param nachname Surname of the new user
     * @param geburtsdatum Birth of Date
     * @param email Email address
     * @param passwordHash Password Hash
     * @param passwordHashWdh Password Hash
     * @param wohnort City
     * @param plz Postcode
     * @param straße Street
     * @param hausnummer House number
     * @param adresszusatz Additional address information
     * @return Return the created entry in hte database
     * @throws UnmatchingPasswordException
     * @throws EmptyInputValueException
     * @throws UserAlreadyExistsException
     * @throws RequiredFactoryFailedException
     * @throws EmptyResultSetException
     */
    public static Registrierung createRegistrierung(String vorname, String nachname, Date geburtsdatum, String email, String passwordHash, String passwordHashWdh, String wohnort, int plz, String straße, int hausnummer, String adresszusatz)
            throws UnmatchingPasswordException, EmptyInputValueException, UserAlreadyExistsException, RequiredFactoryFailedException, EmptyResultSetException {
        vorname = SupportMethods.removeHTMLCode(vorname);
        vorname = SupportMethods.removeSQLInjections(vorname);
        nachname = SupportMethods.removeHTMLCode(nachname);
        nachname = SupportMethods.removeSQLInjections(nachname);
        email = SupportMethods.removeHTMLCode(email);
        email = SupportMethods.removeSQLInjections(email);
        wohnort = SupportMethods.removeHTMLCode(wohnort);
        wohnort = SupportMethods.removeSQLInjections(wohnort);
        straße = SupportMethods.removeHTMLCode(straße);
        straße = SupportMethods.removeSQLInjections(straße);
        adresszusatz = SupportMethods.removeHTMLCode(adresszusatz);
        adresszusatz = SupportMethods.removeSQLInjections(adresszusatz);

        // Cast Email to lower case
        email = email.toLowerCase();

        // Check Password
        if (!passwordHash.equals(passwordHashWdh)) {
            throw new UnmatchingPasswordException();
        }

        // Check whether all requiered Input Fields are filled
        if (vorname.equals("")
                || nachname.equals("")
                || geburtsdatum.equals("")
                || email.equals("")
                || passwordHash.equals("")
                || wohnort.equals("")
                || plz == 0
                || straße.equals("")
                || hausnummer == 0) {
            throw new EmptyInputValueException();
        }

        try {
            getRegistrierungByEmail(email);
            throw new UserAlreadyExistsException();
        } catch (ResultSetIsNullException e) {
            e.printStackTrace();
            throw new RequiredFactoryFailedException();
        } catch (EmptyResultSetException e) {
            // continue
        }

        // Now create user
        Connection c = Connector.getConnection();
        String sql = QueryBuilder.createUser(vorname, nachname, geburtsdatum, email, passwordHash, hausnummer, straße, adresszusatz, plz);
        Connector.executeQuery(c, sql);
        Registrierung registrierung = null;

        try {
            registrierung = getRegistrierungByEmail(email);
        } catch (EmptyResultSetException e) {
            e.printStackTrace();
            SupportMethods.close(c);
            throw new EmptyResultSetException();
        } catch (ResultSetIsNullException e) {
            e.printStackTrace();
            SupportMethods.close(c);
            throw new RequiredFactoryFailedException();
        }

        Email_Sender.sendMail(registrierung.getEmail(), "Wilkommen bei Cineflexxx", "Hallo " + registrierung.getVorname() + ", \n\n wir freuen uns, dass du dich für Cineflexxx entschieden hast und wünschen dir viel Spaß bei unseren Kinofilmen.\n\nDein Cineflexxx Team");

        return registrierung;
    }

    /**
     * Returns a Registrierung for a given Email address. Use this to check whether a account already exists for an email
     * @param email Email address of th eaccount
     * @return Returns registration object
     * @throws ResultSetIsNullException
     * @throws EmptyResultSetException
     */
    public static Registrierung getRegistrierungByEmail(String email)
            throws ResultSetIsNullException, EmptyResultSetException {
        Connection c = Connector.getConnection();
        String sql = QueryBuilder.getUserByEmail(email);
        ResultSet rs = Connector.getQueryResult(c, sql);
        Registrierung registrierung = null;

        if (rs == null) {
            SupportMethods.close(c, rs);
            throw new ResultSetIsNullException();
        }

        if (SupportMethods.getResultSetSize(rs) < 1) {
            SupportMethods.close(c, rs);
            throw new EmptyResultSetException();
        }

        try {
            rs.next();
            registrierung = new Registrierung(
                    rs.getInt("PID"),
                    rs.getString("Vorname"),
                    rs.getString("Nachname"),
                    rs.getDate("GebDatum"),
                    rs.getString("E-Mail"),
                    rs.getString("Passwort"),
                    rs.getInt("PLZ"),
                    rs.getString("Straße"),
                    rs.getInt("Hausnummer"),
                    rs.getString("Adresszusatz")
            );
        } catch (SQLException e) {
            SupportMethods.close(c, rs);
            e.printStackTrace();
        }

        SupportMethods.close(c, rs);
        return registrierung;
    }
}
