Return-Path: <linux-s390+bounces-20967-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n5tIGsiAM2oFDAYAu9opvQ
	(envelope-from <linux-s390+bounces-20967-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 07:23:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B732F69DAFD
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 07:23:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=NXwInkEt;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20967-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20967-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF9C33035279
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 05:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BAD37F019;
	Thu, 18 Jun 2026 05:22:22 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE137F015
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 05:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760142; cv=none; b=gW+F73vH3WmmqjZ601mbAk9r+YkW2IqE5PysUfl+7wuvZzrowmYRMm1oqUo6qfnxV/8/x2Wq2y+bw0vfrHQulbLTPG1kxoPgzETsTpopKxva9NA+93LUSLa+JBLv+UnjtKUilrJl33cw7sgZCiXpiLhlUMaaXrdEsSKmCEudAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760142; c=relaxed/simple;
	bh=ujHIkgaFkBy6pzwdW+J2dDclqeqHbjwXRfcfiQC7iFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rboy0Bcp+v5fA/oC7YKffZn3HKKftN7m+nn8XZ6IJYemY6JuaW3kzuldhtUGVuFis8mFTtoRUFOp84JZasj0mX6DdfLEswPCwMOLmH+QbsQluicbGqGLu4YH9da3FLmLdKShcDnXxm4VpoqZZZwxfRZGavdBpz2Ayb4IYhCKw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NXwInkEt; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmZFG1016994;
	Thu, 18 Jun 2026 05:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m0IloM
	2rnGBe46y+BZoaswnSV38kRumiaJYQMq7RbTA=; b=NXwInkEtofV+YUQdtvAech
	JXkAk5x+m9GGvzWq3LuKgQ0tYlcPJUHe+9as02+qkJV08nKugqDt/kd5SlI3+fC+
	HNwrTqH90ZdC8kK1MLZDt9BddUihVcKn12tEfe2n8ndecPwwIYL5zKuH6jJ1GFP+
	Ux/qk0vqNVnzjZUxpAU6e3cKNJy+e37LwIxll1RGnuGR/nudcaEGdda7if93Vuoh
	m0/WBz+PpgNfDoCk+pte1muV0pNj9lgYY8XfhdCrBgCnTUc/xgdTsDcLHe1ntvcT
	KTZ6/1E10nRaY/8KC+tgVMyhPEUmxd5uCMekKkSIOsG8IPKuJRwDbNZ+kgWuVeNA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxebmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:22:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5JbIp021417;
	Thu, 18 Jun 2026 05:22:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a4c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:22:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I5MAZ050987330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 05:22:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F416420043;
	Thu, 18 Jun 2026 05:22:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C03BA20040;
	Thu, 18 Jun 2026 05:22:09 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 05:22:09 +0000 (GMT)
Message-ID: <f07dd1a0-b41b-4699-9e82-4005f44bb55b@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/17] target/s390x: Support AES ECB for cpacf km
 instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-5-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a338086 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=QgfHRvl5YYpBVYqF5jIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfXzmv44JBkf+/n
 kQIFR/ATA6PDWkTU0B/fSeXpzkZVslkuXWZJ2LOlks1Yv7wqxWCw8N7Of7RnFvrE0QYBwNzq5r/
 2NsNfs1uhID2rwrwetkxV1ygg+UdRE9Cudi+hJw4bzJ0uiV8s6Ro4JbTYuCB3TcJ5YIFPJGZLo+
 Vn2gJdGzFWEux0DUpsXB2gNW7FbMo7eDqPgWf0y3T2bmojlRplYFusjzBI0nf9fu83C6x6LdJq+
 9bmuhZZqWGuYZgWC7eF0gTBJhKK0JNIpKUSBiyokIQlFJR4T9XAHj5JSyjvqk/yLKqWOPKdZADU
 V9tQOOeRmD2N5s2f0XYaG5piBOFX5YjTjaiWA1baHXtqrGe/2d9/h3MACj/PVE6XptBbSTLLfMm
 hGZPs0oCgJXQocvX4Osz5qhA22sugwRe2t8u4ZwHVrRE594hV2f/sYTgSbMtK72ARjiXRtGglcI
 9PowYiFHB/oSJVDVfSQ==
X-Proofpoint-GUID: oBJnti6qCrj1ytSywMCLxmLUdnQWo2Sx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX0mw+yyoUhOVR
 TpYdiXPlKVVVrVSExhUlcra5VXRezqUifykH3tOAR2BcZgaeqFFpCXkBEnGalQsJUF7aY2bY+VD
 AUS1PV4LKtbmWUOwNMoOaPXz72Xl5j8=
X-Proofpoint-ORIG-GUID: oBJnti6qCrj1ytSywMCLxmLUdnQWo2Sx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045
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
	TAGGED_FROM(0.00)[bounces-20967-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
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
X-Rspamd-Queue-Id: B732F69DAFD



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
> and CPACF_KM_AES_256 for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the one typo (see below) fixed:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |   3 +
>   target/s390x/tcg/cpacf.h         |   6 ++
>   target/s390x/tcg/cpacf_aes.c     | 113 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 147 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_aes.c
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 5cf5b92c37..a35d1fd2f9 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -921,6 +921,9 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KLMD_SHA_256,
>       S390_FEAT_KLMD_SHA_512,
>       S390_FEAT_PRNO_TRNG,
> +    S390_FEAT_KM_AES_128,
> +    S390_FEAT_KM_AES_192,
> +    S390_FEAT_KM_AES_256,
>   };
>   
>   /****** END FEATURE DEFS ******/
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> index e2c36306b2..36d0c81893 100644
> --- a/target/s390x/tcg/cpacf.h
> +++ b/target/s390x/tcg/cpacf.h
> @@ -18,4 +18,10 @@ int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                    uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
>                    uint32_t type);
>   
> +/* from crypto_aes.c */

Should be cpacf_aes.c instead of crypto_aes.c

> +int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                  uint32_t type, uint8_t fc, uint8_t mod);
> +
[ snip ]

