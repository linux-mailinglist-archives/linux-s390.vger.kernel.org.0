Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A669ADEE
	for <lists+linux-s390@lfdr.de>; Fri, 23 Aug 2019 13:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfHWLQu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 23 Aug 2019 07:16:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727025AbfHWLQt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 07:16:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NBGX6j019913
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 07:16:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ujedbspwd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 07:16:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 23 Aug 2019 12:16:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 23 Aug 2019 12:16:43 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7NBGgdQ49021100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 11:16:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81580A405B;
        Fri, 23 Aug 2019 11:16:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D19EA405F;
        Fri, 23 Aug 2019 11:16:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.28.218])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Aug 2019 11:16:42 +0000 (GMT)
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: STSI tests
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-5-frankja@linux.ibm.com>
 <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Fri, 23 Aug 2019 13:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3BuPIrtxKUdlKPYkmCoxSTaHAnOvUIgGQ"
X-TM-AS-GCONF: 00
x-cbid: 19082311-0020-0000-0000-0000036322C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082311-0021-0000-0000-000021B862B0
Message-Id: <40b29623-8fcf-2a8b-6e44-c94a958f3044@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230120
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3BuPIrtxKUdlKPYkmCoxSTaHAnOvUIgGQ
Content-Type: multipart/mixed; boundary="dKiOaeDN0le2wFE7maVhLPHYgKkvf7ppL";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <40b29623-8fcf-2a8b-6e44-c94a958f3044@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: STSI tests
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-5-frankja@linux.ibm.com>
 <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>
In-Reply-To: <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>

--dKiOaeDN0le2wFE7maVhLPHYgKkvf7ppL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/19 12:57 PM, Thomas Huth wrote:
> On 8/21/19 12:47 PM, Janosch Frank wrote:
>> For now let's concentrate on the error conditions.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/Makefile      |  1 +
>>  s390x/stsi.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |  3 ++
>>  3 files changed, 88 insertions(+)
>>  create mode 100644 s390x/stsi.c
>>
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index 3453373..76db0bb 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -13,6 +13,7 @@ tests +=3D $(TEST_DIR)/gs.elf
>>  tests +=3D $(TEST_DIR)/iep.elf
>>  tests +=3D $(TEST_DIR)/cpumodel.elf
>>  tests +=3D $(TEST_DIR)/diag288.elf
>> +tests +=3D $(TEST_DIR)/stsi.elf
>>  tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
>> =20
>>  all: directories test_cases test_cases_binary
>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>> new file mode 100644
>> index 0000000..0f90c9a
>> --- /dev/null
>> +++ b/s390x/stsi.c
>> @@ -0,0 +1,84 @@
> [...]
>> +static inline unsigned long stsi_get_fc(void *addr)
>> +{
>> +	register unsigned long r0 asm("0") =3D 0;
>> +	register unsigned long r1 asm("1") =3D 0;
>> +	int cc;
>> +
>> +	asm volatile("stsi	0(%2)\n"
>=20
> Shouldn't that be %3 instead?

Yup, although it doesn't really matter, as the address is ignored.

>=20
>> +		     "ipm	%[cc]\n"
>> +		     "srl	%[cc],28\n"
>> +		     : "+d" (r0), [cc] "=3Dd" (cc)
>> +		     : "d" (r1), "a" (addr)
>> +		     : "cc", "memory");
>> +	assert(!cc);
>> +	return r0 >> 28;
>> +}
>> +
>> +static void test_fc(void)
>> +{
>> +	report("cc =3D=3D 3",  stsi(pagebuf, 7, 0, 0) =3D=3D 3);
>> +	report("r0 =3D=3D 3",  stsi_get_fc(pagebuf) >=3D 2);

Just changed it to:
"invalid fc"
"query fc >=3D 2

>=20
> I'd like to suggest to change the string to "r0 >=3D 2", too.
>=20
>  Thomas
>=20



--dKiOaeDN0le2wFE7maVhLPHYgKkvf7ppL--

--3BuPIrtxKUdlKPYkmCoxSTaHAnOvUIgGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1fyxkACgkQ41TmuOI4
ufjunBAAlJ2DsDxxeAFmclBSNwfYDjvOANmzNBmltRtm9IjQGt750dnRUPknQ7E8
Ppv7Hy3MHQk9VUBqh8KqN0KTe6H08k5EotCjlZ865vqa8CuMyT44cTSUPeIksCDl
V3RKW3DyxdvvLvqLRnoa9IXdudiy4pgVI9RzrM0me3r2sGkQ4nUFHAiCqD/RG0MC
2hBX0bo2REEqrcFvJH+o4wNh3mHZuVDQ1C+7Gstq7xOIGe5PBxv28R1eNz5yfsuX
ymrj445s6eP5mvx5QmkPZ7EAP9nxiE8woiJYFzgcczZR9zIxUC+S0jASGUm/MpZc
P02lGkpli43cJHm5qb7ZtPXPtG03OwnvmIvJmYTsPjU/7XW7Xe8CRYrvOsy3Heuo
RbssJHLtNxE7pfwkmuVr4sXbfFOYrVLuoXdwfUE15PPvWdoSbnxlDyKadWu7YNEF
btV9MJef4s4XyztSsxpXuKM50UQ4NT/eBPOydUoRuizG8YtiVZahs1Vvm1w0+MI8
jAbk1XMDR0L02oscTRFd3bJkv2/Zocnux6imijkW5SIOaPMf4+yGuhaYpN1Jo+Pp
/qKbb6hBZPEMtxaHV8jE+NqsWh0yWQFrUHplOpJkwgWu9lKASzMeIXzR3sPd2L7I
/ypnbKEgNN6R9IKpEOC7Qv4G1ebjvbKcVIzFGBU7N81Jw0Cv6mY=
=dkqd
-----END PGP SIGNATURE-----

--3BuPIrtxKUdlKPYkmCoxSTaHAnOvUIgGQ--

