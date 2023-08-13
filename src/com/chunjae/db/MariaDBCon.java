package com.chunjae.db;

import java.sql.*;

public class MariaDBCon implements DBC {
  final String DRIVER = "org.mariadb.jdbc.Driver";
  final String DNS = "localhost";
  final String PORT = "3306";
  final String NAME = "gnj";
  final String USER = "root";
  final String PASS = "1234";
  final String DATABASE = "gnj";
  final String URL = "jdbc:mariadb://" +DNS+":"+PORT+"/"+DATABASE;

  Connection conn = null;

  public MariaDBCon() {
  }

  public Connection connect() {
    try {
      Class.forName(DRIVER);
      this.conn = DriverManager.getConnection(URL, USER, PASS);
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    } catch (Exception e){
      e.printStackTrace();
    }
    return this.conn;
  }

  public void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
    try{
        if(rs!=null){
          rs.close();
        }
        if(pstmt!=null){
          pstmt.close();
        }
        if(conn!=null){
          conn.close();
        }
    }catch(SQLException e){
      throw new RuntimeException(e);
    }catch(Exception e){
        e.printStackTrace();
    }
  }

}
