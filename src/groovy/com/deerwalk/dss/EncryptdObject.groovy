package com.deerwalk.dss

import grails.converters.JSON
import org.hibernate.HibernateException
import org.hibernate.usertype.UserType

import javax.crypto.Cipher
import javax.crypto.spec.SecretKeySpec
import java.security.MessageDigest
import java.sql.PreparedStatement
import java.sql.ResultSet
import java.sql.SQLException
import java.sql.Types

/**
 * Created with IntelliJ IDEA.
 * User: deerwalk
 * Date: 9/24/13
 * Time: 7:05 PM
 * To change this template use File | Settings | File Templates.
 */
abstract class EncryptdObject<T>  implements UserType{

	protected String salt = EncryptConfig.SALT
	protected String key = EncryptConfig.KEY

	int[] sqlTypes() {
		[Types.VARCHAR] as int[]
	}

	Class returnedClass() {
		T
	}

	boolean equals(x, y) {
		x == y
	}

	int hashCode(x) {
		x.hashCode()
	}

	Object deepCopy(value) {
		value
	}

	boolean isMutable() {
		false
	}

	Serializable disassemble(value) {
		value
	}

	def assemble(Serializable cached, owner) {
		cached
	}

	def replace(original, target, owner) {
		original
	}

	Object nullSafeGet(ResultSet resultSet, String[] names, Object owner) throws HibernateException, SQLException {
		String str = resultSet.getString(names[0])
		str ? decrypt(str) : null
	}

	void nullSafeSet(PreparedStatement statement, Object value, int index) {
		statement.setString(index, value!=null ? encrypt(value) : null)
	}

	public abstract String encrypt(T plaintext);

	public abstract T decrypt(String ciphertext);

}
