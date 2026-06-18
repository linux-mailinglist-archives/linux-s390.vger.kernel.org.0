Return-Path: <linux-s390+bounces-20980-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 45y9NLOOM2pgDQYAu9opvQ
	(envelope-from <linux-s390+bounces-20980-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 08:22:43 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0769DD38
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 08:22:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=o1jImDmQ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20980-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20980-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E288030158B4
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21D632FA18;
	Thu, 18 Jun 2026 06:22:40 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBD32D0FC
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 06:22:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763760; cv=none; b=N49JaizuAoT69XkkCMDR5Ofd6PbyrjPSZvsQyMlQLizILDH07SpD2L9+NFBvRkaPtUkZL4aK7uWECuoMxQoATBtL+JBgUTbRChu4b21XQRm6s3GLfngNSD0Z9aG8m5PJPcF3gOK5EMX0xvLnA3ZE2KzRO9z4uDGoEL9rTqy1zI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763760; c=relaxed/simple;
	bh=FxTNpzPLKonraMwaJWtJmwtb2yNfTeQQgnCuAfTzfLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTQS4uMWGKQmKOZDCN3KvgkGa2iSJtwvPjBbjIfnmh+O0KIMmgYsMMp97dPvn5yyl5GNGsh/et/Zk68WnOXjlqCA9vob+DWxWykMeJsE/L6OEuGV+oA0zTf2KVAd+Rls45dBvK9+QHNA0PrnoyHyc+mkA3XTYfeeSnfQulLIeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o1jImDmQ; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmLU51000465;
	Thu, 18 Jun 2026 06:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gV//1P
	75ml38jIptNxNh5NONBRIzlZeGAsd1+h6GlHI=; b=o1jImDmQBJk/7dJyatcLSR
	WnJeNyG/N5WnZPMvSOY8lv6GTLCn4v3Wc+nRoE8ibFL8ukJBw+9uxA7W7z9sKrCv
	UpkZbQe6W7q3tLBJsOfG/4pBXZY3VuqJJEkNa2b3ygHROHJp61gBqQSOagItdqh7
	fLred9Q6aIoTGFQbduyPsNzNVjq2/4/j5QcS+5v0v9jyzK56mHXpaOqmH4FckTbj
	GRAQ9xVAR6tlxI6pvwUwIDEexObLLmIEBpE01s1tqpqE/qG3nhyZQ1OTDUquVAtu
	mplGr4ppJZXHh8iPslhcXlc+Mj0z3gssBGxHcjlrDThEu0FKISgNlzadIzQeaRPg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6k1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:22:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I6Jb2e029758;
	Thu, 18 Jun 2026 06:22:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722bh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 06:22:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I6MSYu30999034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 06:22:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04A6A2004D;
	Thu, 18 Jun 2026 06:22:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C700C2004B;
	Thu, 18 Jun 2026 06:22:27 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 06:22:27 +0000 (GMT)
Message-ID: <66653376-f6d7-4370-b963-201053d7e903@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:22:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/17] target/s390x: Support protected key AES XTS for
 cpacf km instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-15-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-15-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX19xD6v7dZ7pb
 9SSU23ciCHMOJAVVA5JY58fT8TYdL57Uf0phcyUZ38REtn9zi0C0dkbAqeOb9KQb0UK1+h4m9+9
 1oCSs5ktSDGfgG0TXSEPMcQdBdIe9rC8j9hf+O0ukLC1e4PGcLJ0Q8vpNpa//i0Rao4sqQ7hcQA
 5uu83QlEos+y45g6WIaDg0unr79EJCTRbP73CXcwsy9T5wbd0Vtm9IKMxZoEGl0fxSql/CRrG3l
 OOgmq1p8iaBeFu0qSX98O8++p/hfO8km24Ir401yK3aATFQ+vfrsl7EreNTbGQZo40OKsx40mcL
 wMqrvNJakow+Kvvye/EubHVHiEamThFmIK8sJwnAUDeAqixkDkMn/h8LkNNKifXaWc/BHFssG70
 M/NRQWu6rPd3RZCTHGHZsjobjL6MHSrMVNTXy+YR3i/U7E3PjLAsZVXNKzXZUTo6vr0oFIRQz11
 djAHLhgKKh3P0AvxVqw==
X-Proofpoint-GUID: uZoQv_U0PZDcUSfNBVdM7Xe1c2BqSb-G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX5ZPgLpqFbf44
 b2I8wOV6DYel3e07Y75m8ZH62rSXRjjNc4nFazDbkFEUzzFHVq4nmVAiZHO8Tp5ZqTs2SoZAWt8
 yyZQuhNlzqqdl0VcNA1ufa/ZVthgRzc=
X-Proofpoint-ORIG-GUID: uZoQv_U0PZDcUSfNBVdM7Xe1c2BqSb-G
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a338ea8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=bjhKnsnRy4Y7tZLOtR4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180055
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
	TAGGED_FROM(0.00)[bounces-20980-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[fcallies@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fcallies@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CC0769DD38



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PAES_256
> for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the suggestion:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |   2 +
>   target/s390x/tcg/cpacf.h         |   4 ++
>   target/s390x/tcg/cpacf_aes.c     | 106 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   6 ++
>   4 files changed, 118 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 126bacb281..c4c59c3504 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -929,6 +929,8 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KM_EAES_256,
>       S390_FEAT_KM_XTS_AES_128,
>       S390_FEAT_KM_XTS_AES_256,
> +    S390_FEAT_KM_XTS_EAES_128,
> +    S390_FEAT_KM_XTS_EAES_256,

PAES or ENCRYPTED_AES

>       S390_FEAT_KMC_AES_128,
>       S390_FEAT_KMC_AES_192,
>       S390_FEAT_KMC_AES_256,

[ snip ]


