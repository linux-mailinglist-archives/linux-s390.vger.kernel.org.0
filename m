Return-Path: <linux-s390+bounces-21027-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9opFLH+NGozlwYAu9opvQ
	(envelope-from <linux-s390+bounces-21027-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 10:32:49 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334B6A49BE
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 10:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=FB3a7ygy;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21027-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21027-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52C1E3013A85
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 08:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEAE34D385;
	Fri, 19 Jun 2026 08:32:47 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730ABA34
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:32:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857966; cv=none; b=Fizl6FpzAGbic3fwLxRAjPd2zXdXYcs9++zrOxWG4H/R3EcIP9PtAvTfFKc6f5JObhEJlQBv0+CcR1ROkvsiBzngKZO8MPyZCuQoQHd0B7pkfvk0VKSwWLck8mieLf5ze1pFkVXtzAjp7SUKrjyDbz8NjTThFF81uy8EBocFyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857966; c=relaxed/simple;
	bh=ruSZjuqmwp4Sh/agpBzelee1guvHyxcX9SaA3IcwGNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEis+SCEbXb5r3i4uuLW0Fq7IAMe32raezYbDHoAsxocHtqPJIdaXjK9QeHZXp3boJD0K28L9owtiZY3wWmquP68q5+5CFs/vvDaowLPS85akq+OSWWQCPILq93zXP6SqGpy94JALPumumA04ZzWuH8PyJ0coBft5IWFqNniDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FB3a7ygy; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mRab1590124
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZM5eKo
	bgCK8EvG/PPftkIBA2yAtSAPjOTaBiBTVo68c=; b=FB3a7ygyLaor9ubbUQqrPN
	COU4etdqaK24RGpI81pykGB22V5FZBJLFQlptRv9VN4NJwL+GYWBdQuodl4JiLYc
	tLUENX3LUy9wprpGsGi6dNE4vq2bze39H4yjRJ4pE5bl7oTGZ8HxjlatWwBLBI/H
	+hOhGh1NBwg6xoS/9RBbL6CQPOkGATehq/2Z8i1g/RRdbCTLSK4Yxu8NEaEdS2CW
	Ycu3KSBbyM72IWXRVlS9+3miuxqxkG1guE5o9Z7MS5qaq6GuvNUfmc0vgQIRLOhi
	UESgHaxjP06OXwp7apLISqqLbTdcs/RDcyWzHpCSz0LdMLxZTHuTa5BYPh9oTh7w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxccx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:32:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J8Jais030657
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:32:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1727xxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:32:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J8WdYU53018964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 08:32:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0012004E;
	Fri, 19 Jun 2026 08:32:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 631B12004D;
	Fri, 19 Jun 2026 08:32:39 +0000 (GMT)
Received: from [9.111.159.204] (unknown [9.111.159.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 08:32:39 +0000 (GMT)
Message-ID: <a4234cb9-5d92-4b97-979d-2b0be9cbeb1e@linux.ibm.com>
Date: Fri, 19 Jun 2026 10:32:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
To: Holger Dengler <dengler@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
Content-Language: en-US, de-DE
From: Ingo Franzki <ifranzki@linux.ibm.com>
In-Reply-To: <20260619074541.1710716-2-dengler@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3NiBTYWx0ZWRfX/Avmr+qlyN9Y
 Ev1v6S5G7UODvjVgM8P0xxmu1BRwI5cgSGTZgZC4O5dD65hoMI5++sU4Dsmz8sTYzT9IbL4Qlc7
 IfXd1NLhosusU+Frc/diD38y9KV/Cm2DRfYDkzmir5BiEYuQhHSgdgbJLQBzQJPgOFdWYAkJOwX
 d2VQUQr51JBR0kOF4aqqBSF7d8ELst9lduVd/6AOVC06+qkKffZLgi1/ID6X3+WwOnFgx7cgdEN
 Oap4//eO8+5laPmdY5VdzsBWTH9PAhsQJZrInWCvkmM6E/+Y6rxE7H2om2NY4xDgjfniKSyPaG1
 3pL5WV7J5uFyPFK+jVJf3ctU1eo95GIdMbB7KeDFViSmpZ4lbRmyL+GQc4Xa84msuKUrghj5U3O
 Ku16Zs9aHDonU4J+gaYhjKuBdYh58g8/21E60bCY9QPNdm9saC3JyhH04aGrMDkhB3yQtCRbxEE
 6SyZavHsyfFrBO7frBw==
X-Proofpoint-GUID: JEcq3CHDBb_y8G5iYEN8PMmkmcp5DwkM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3NiBTYWx0ZWRfX4yGmRjDRWSlN
 nX8nYN6DF/cFxeOgA6b85h5EY2Rxg4ZwjbfuZ6jzkga0BlcxiOxtFd7yRNBtnrKkK/D89aCShJu
 J7skWwC3nKIx2Ro3SAfeg/+hCVFT0l4=
X-Proofpoint-ORIG-GUID: JEcq3CHDBb_y8G5iYEN8PMmkmcp5DwkM
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a34feac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=GWOYupDnfj2zWeQRS-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21027-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dengler@linux.ibm.com,m:freude@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ifranzki@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ifranzki@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9334B6A49BE

On 19.06.2026 09:45, Holger Dengler wrote:
> As part of the verification, the PKEY_VERIFYPROTK ioctl checks for
> supported keytype, which are derived from the bit-size of the key. The
> calculation for the bit-size of a protected key has to take into
> account, that the length of the protected key blob also includes the
> length of the wrapping key verification pattern (WKVP). Subtract the
> length of the MKVP from the protected key length fixes this
> calculation.
> 
> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index d6b595eb3370..2160e1de3014 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -334,7 +334,8 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
>  	if (copy_from_user(&kvp, uvp, sizeof(kvp)))
>  		return -EFAULT;
>  
> -	keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
> +	keytype = pkey_aes_bitsize_to_keytype(8 * (kvp.protkey.len -
> +						   AES_WK_VP_SIZE));
>  	if (!keytype) {
>  		PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
>  			     __func__, kvp.protkey.len);

Why not simply use 

     t->keytype = kvp.protkey.type;

and remove the whole 'keytype = pkey_aes_bitsize_to_keytype(....)' thing ? 
The type of the protected key is already contained in the protected key structure, so why trying to guess it from the size again? 

You will need a length check for the 'memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len);' (regardless of how you determine the type).  

-- 
Ingo Franzki
eMail: ifranzki@linux.ibm.com  
Linux on IBM Z Development
IBM Campus 1, 71139 Ehningen, Germany

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Ehningen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM DATA Privacy Statement: https://www.ibm.com/privacy/us/en/

