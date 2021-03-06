package factory;

import db_connector.Connector;
import db_connector.QueryBuilder;
import exception.EmptyResultSetException;
import exception.FailedObjectCreationException;
import exception.ResultSetIsNullException;
import helper.SupportMethods;
import java.sql.SQLException;
import oo.Gebaeude;
import java.sql.Connection;
import java.sql.ResultSet;

public class GebaeudeFactory {
    /**
     * Returns an array of all buildings in the database
     * @param mockRs For tests
     * @return Returns Gebäude Array
     */
    public static Gebaeude[] getGebaeude(ResultSet mockRs) {
        Gebaeude[] gebäude = null;
        Connection c = Connector.getConnection();
        String sql = QueryBuilder.showAllCinemas();
        ResultSet rs = null;

        if(mockRs == null)
        {
            rs = Connector.getQueryResult(c, sql);
        }

        else
        {
            rs = mockRs;
        }

        if (rs != null) {
            int rsSize = SupportMethods.getResultSetSize(rs);

            if (rsSize > 0) {
                gebäude = new Gebaeude[rsSize];
                try {
                    for(int i = 0; i < rsSize; i++){
                        rs.next();
                        int gebID = rs.getInt("GebäudeId");
                        String strasse = rs.getString("Straße");
                        int hausnummer = rs.getInt("Hausnummer");
                        int plz = rs.getInt("PLZ");
                        String ort = rs.getString("Ort.Ortsname");

                        gebäude[i] = new Gebaeude(gebID, strasse, hausnummer, plz, ort);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            SupportMethods.close(c, rs);
            return gebäude;
        } else {
            SupportMethods.close(c, rs);
            return gebäude;
        }
    }

    /**
     *  Returns an array of all buildings in the database
     * @return returns Gebäude Array
     */
    public static Gebaeude[] getGebaeude()
    {
        return getGebaeude(null);
    }

    /**
     * Returns the Gebäude with the specified ID
     * @param id ID of the building
     * @return Returns a single Gebäude
     * @throws ResultSetIsNullException
     * @throws EmptyResultSetException
     * @throws FailedObjectCreationException
     */
    public static Gebaeude getGebaeudeById(int id)
        throws ResultSetIsNullException, EmptyResultSetException, FailedObjectCreationException {
        Connection c = Connector.getConnection();
        String sql = QueryBuilder.getGebaeudeById(id);
        ResultSet rs = Connector.getQueryResult(c, sql);
        Gebaeude gebaeude = null;

        if(rs == null) {
            throw new ResultSetIsNullException();
        }

        if(SupportMethods.getResultSetSize(rs) < 1) {
            throw new EmptyResultSetException();
        }

        try {
            rs.next();
            gebaeude = new Gebaeude(
                rs.getInt("GebäudeID"),
                rs.getString("Straße"),
                rs.getInt("Hausnummer"),
                rs.getInt("PLZ"),
                OrtsFactory.getOrtByPLZ(rs.getInt("PLZ")).getOrtsName()
            );
        }catch(SQLException e) {
            e.printStackTrace();
            throw new FailedObjectCreationException();
        }

        SupportMethods.close(c, rs);
        return gebaeude;
    }
}
