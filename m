Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10A1469F6
	for <lists+linux-s390@lfdr.de>; Thu, 23 Jan 2020 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgAWNyz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 23 Jan 2020 08:54:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgAWNyy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jan 2020 08:54:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NDqOPx127615
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 08:54:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xqa25y4g7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 08:54:53 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Jan 2020 13:54:51 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Jan 2020 13:54:48 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00NDrvUH42664214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 13:53:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8EAC42041;
        Thu, 23 Jan 2020 13:54:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85FDF4203F;
        Thu, 23 Jan 2020 13:54:47 +0000 (GMT)
Received: from dyn-9-152-224-146.boeblingen.de.ibm.com (unknown [9.152.224.146])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jan 2020 13:54:47 +0000 (GMT)
Subject: Re: [kvm-unit-tests PATCH v4 2/9] s390x: smp: Only use smp_cpu_setup
 once
To:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc:     thuth@redhat.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, cohuck@redhat.com
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-3-frankja@linux.ibm.com>
 <ef7894ff-4179-6730-ce28-c48e7730eff8@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Thu, 23 Jan 2020 14:54:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ef7894ff-4179-6730-ce28-c48e7730eff8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V2umUpQQJqxbaQrGZ00qKqAwEO25NLbav"
X-TM-AS-GCONF: 00
x-cbid: 20012313-0008-0000-0000-0000034C091E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012313-0009-0000-0000-00004A6C7591
Message-Id: <e09c42a7-279a-7e8b-8241-26c69940cdd0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_08:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=11 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230119
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V2umUpQQJqxbaQrGZ00qKqAwEO25NLbav
Content-Type: multipart/mixed; boundary="5ds5ufiKTnugcR6YKVnm1LkVNANTpFlOo"

--5ds5ufiKTnugcR6YKVnm1LkVNANTpFlOo
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/23/20 2:45 PM, David Hildenbrand wrote:
> On 21.01.20 14:42, Janosch Frank wrote:
>> Let's stop and start instead of using setup to run a function on a
>> cpu.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>  s390x/smp.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index e37eb56..3e8cf3e 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -53,7 +53,7 @@ static void test_start(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	set_flag(0);
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	report(1, "start");
>>  }
>> @@ -109,6 +109,7 @@ static void test_store_status(void)
>>  	report(1, "status written");
>>  	free_pages(status, PAGE_SIZE * 2);
>>  	report_prefix_pop();
>> +	smp_cpu_stop(1);
>> =20
>>  	report_prefix_pop();
>>  }
>> @@ -137,9 +138,8 @@ static void test_ecall(void)
>> =20
>>  	report_prefix_push("ecall");
>>  	set_flag(0);
>> -	smp_cpu_destroy(1);
>> =20
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	set_flag(0);
>>  	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>> @@ -172,9 +172,8 @@ static void test_emcall(void)
>> =20
>>  	report_prefix_push("emcall");
>>  	set_flag(0);
>> -	smp_cpu_destroy(1);
>> =20
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	set_flag(0);
>>  	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
>> @@ -192,7 +191,7 @@ static void test_reset_initial(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("reset initial");
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> @@ -223,7 +222,7 @@ static void test_reset(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("cpu reset");
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>>  	report(smp_cpu_stopped(1), "cpu stopped");
>> @@ -232,6 +231,7 @@ static void test_reset(void)
>> =20
>>  int main(void)
>>  {
>> +	struct psw psw;
>>  	report_prefix_push("smp");
>> =20
>>  	if (smp_query_num_cpus() =3D=3D 1) {
>> @@ -239,6 +239,12 @@ int main(void)
>>  		goto done;
>>  	}
>> =20
>> +	/* Setting up the cpu to give it a stack and lowcore */
>> +	psw.mask =3D extract_psw_mask();
>> +	psw.addr =3D (unsigned long)cpu_loop;
>> +	smp_cpu_setup(1, psw);
>> +	smp_cpu_stop(1);
>> +
>>  	test_start();
>>  	test_stop();
>>  	test_stop_store_status();
>> @@ -247,6 +253,7 @@ int main(void)
>>  	test_emcall();
>>  	test_reset();
>>  	test_reset_initial();
>> +	smp_cpu_destroy(1);
>> =20
>>  done:
>>  	report_prefix_pop();
>>
>=20
> With this patch, I get timeouts under TCG. Seems to loop forever.
>=20
The branch works on lpar and kvm without a problem.


--5ds5ufiKTnugcR6YKVnm1LkVNANTpFlOo--

--V2umUpQQJqxbaQrGZ00qKqAwEO25NLbav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4ppaYACgkQ41TmuOI4
ufiHYg//es8ywqNE5SVvTOi3PXwJpQ6dY9gTntCRh4n46OMI+KmUobQ2ZDa+RvhG
IUglxBaqOTF5RvLOBwt5W+XdJYcVPtzeGk1KpOXzS5Atby3nxzOSru98wA0jGSdD
a/3gMhPL+ZIuGBUziPlUXahv5WaYsc+jzBfiXFoHVppK0k+0OJDEVfA7+d2AMtEq
yeliAAPm7LJfrnXpnX14Q/0td3LAmR699B3sPipzi3ZelL1xmhzAr80RFXOuzCor
l2/VYDd44jeeB1K5R0JYuRyPLAYMowg8v8MaaDlIr54C+pLWhWLMYG6Lu4GuSfKa
lraQsRztPYprgNArH7QGDQWVem2pr1Rb0jUrVcDkha87REpl9N6So+TX+fLYXt8t
DiC9VgRoyPuq8WI5+SkyzaozVt58JMTNvvioOka3qmxI5YQYUJgvZ31q1YeVQFw9
/jiGaJmtI3Fgpw8thSAZ6aU+pr4N/8r2uXBq+WYlQGglV6xhjPrD0DnHhHY/AIdl
va9QpC5eyexmvrT/gOrYVrs+MQ58X7gon2ivXlx7ykCGtgbLOCD/2X6Oo5V5k639
o1oZr/AqY9DZqicVH9lbeF5+yiAoctKUNenREeYqom/JgJxbTu1sdyhPo/wLkgvw
OsH84nyQVHcxtcpdciJdgD5IfBlkTudaAQXzpa/DNMEwPiamxEQ=
=mNh1
-----END PGP SIGNATURE-----

--V2umUpQQJqxbaQrGZ00qKqAwEO25NLbav--

