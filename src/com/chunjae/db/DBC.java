package com.chunjae.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public interface DBC {
  Connection connect();
  void close(ResultSet var1, PreparedStatement var2, Connection var3);
}
