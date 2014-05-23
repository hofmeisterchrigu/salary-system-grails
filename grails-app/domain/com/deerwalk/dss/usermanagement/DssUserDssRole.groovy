package com.deerwalk.dss.usermanagement

import org.apache.commons.lang.builder.HashCodeBuilder

class DssUserDssRole implements Serializable {

	DssUser dssUser
	DssRole dssRole

	boolean equals(other) {
		if (!(other instanceof DssUserDssRole)) {
			return false
		}

		other.dssUser?.id == dssUser?.id &&
			other.dssRole?.id == dssRole?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (dssUser) builder.append(dssUser.id)
		if (dssRole) builder.append(dssRole.id)
		builder.toHashCode()
	}

	static DssUserDssRole get(long dssUserId, long dssRoleId) {
		find 'from DssUserDssRole where dssUser.id=:dssUserId and dssRole.id=:dssRoleId',
			[dssUserId: dssUserId, dssRoleId: dssRoleId]
	}

	static DssUserDssRole create(DssUser dssUser, DssRole dssRole, boolean flush = false) {
		new DssUserDssRole(dssUser: dssUser, dssRole: dssRole).save(flush: flush, insert: true)
	}

	static boolean remove(DssUser dssUser, DssRole dssRole, boolean flush = false) {
		DssUserDssRole instance = DssUserDssRole.findByDssUserAndDssRole(dssUser, dssRole)
		if (!instance) {
			return false
		}

		instance.delete(flush: flush)
		true
	}

	static void removeAll(DssUser dssUser) {
		executeUpdate 'DELETE FROM DssUserDssRole WHERE dssUser=:dssUser', [dssUser: dssUser]
	}

	static void removeAll(DssRole dssRole) {
		executeUpdate 'DELETE FROM DssUserDssRole WHERE dssRole=:dssRole', [dssRole: dssRole]
	}

	static mapping = {
		id composite: ['dssRole', 'dssUser']
		version false
	}
}
