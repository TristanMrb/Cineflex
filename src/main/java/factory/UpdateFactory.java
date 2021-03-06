package factory;

import db_connector.Connector;
import db_connector.QueryBuilder;
import oo.Vorstellung;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UpdateFactory {
    /**
     *
     * @param v
     * @param plz
     * @param mockRs
     * @return Boolean
     */
    public static boolean checkVorstellungPLZ(Vorstellung v, int plz, ResultSet mockRs) {
        String sql = QueryBuilder.getVorstellungByIdPLZ(v.getVorstellungsID());
        Connection c = null;
        c = Connector.getConnection();

        ResultSet rs = null;

        if(mockRs == null)
        {
            rs = Connector.getQueryResult(c, sql);
        }

        else
        {
            rs = mockRs;
        }

        if(rs != null) {
            try {
                if(rs.next()) {
                    if(rs.getInt("PLZ") == plz) {
                        Connector.closeResultSet(rs);
                        Connector.closeConnection(c);
                        return true;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        Connector.closeResultSet(rs);
        Connector.closeConnection(c);
        return false;
    }

    /**
     *
     * @param v
     * @param plz
     * @return boolean
     */
    public static boolean checkVorstellungPLZ(Vorstellung v, int plz)
    {
        return checkVorstellungPLZ(v, plz, null);
    }
}
