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
 * Time: 5:42 PM
 * To change this template use File | Settings | File Templates.
 */
class EncryptedDouble extends EncryptdObject<Double>  {

	Class returnedClass() {
		Double
	}
	public String encrypt(Double plaintext) {
		Cipher c = Cipher.getInstance('AES')
		byte[] keyBytes = MessageDigest.getInstance('SHA-1').digest("$salt$key".getBytes())[0..<16]
		c.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(keyBytes, 'AES'))
		return c.doFinal(plaintext.toString().bytes).encodeBase64() as String
	}

	public Double decrypt(String ciphertext) {
		Cipher c = Cipher.getInstance('AES')
		byte[] keyBytes = MessageDigest.getInstance('SHA-1').digest("${salt}${key}".getBytes())[0..<16]
		c.init(Cipher.DECRYPT_MODE, new SecretKeySpec(keyBytes, 'AES'))
		def value=new String(c.doFinal(ciphertext.decodeBase64()))
		try{
			return Double.parseDouble(value)
		}catch (e){
			return 0.0F
		}
	}
}

