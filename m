Return-Path: <linux-s390+bounces-22222-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hp4gOl0pVmqh0QAAu9opvQ
	(envelope-from <linux-s390+bounces-22222-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:19:41 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 453837546F0
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 14:19:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=svO3vhlJ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22222-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22222-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CAC43033F8F
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD32D38E12B;
	Tue, 14 Jul 2026 12:02:08 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33310393DCD
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 12:02:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030528; cv=none; b=YCtBs/sTw3kRTrxOEsTLlKJYS9YgqNsm/pMxMSNaB6Mqoz0/vbEvQKjlD4Fph/A0bFPrRHa3MlpkhUvchrmRzbwS1Zhef5f9aHl32g3tKSNYgazVEYPoH73wD/Chn5zCkt2B/rwyW6opaznmbl+HRzIKtnZCKmYVhOIzFgWlGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030528; c=relaxed/simple;
	bh=aeBHZLODJ3TECJUe3f/jxKjFiadiPMG6hlLTunApuJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VngN8yTTaoXl5hTvJftmTGnuWrvlIGGOZrUx2SHnboRIcO9hpUFo8hdIX7EvuQFR3zYZv//sDSvTazBubeH50f5vVrXUPIW9pcbPTtl+GVymPg5vLtQ07CyPE9AZtCq7TPmGaLqsCUMj85trP+Voqr6GJwxBQgGaS8H+wA93nXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svO3vhlJ; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBg2WI1134850;
	Tue, 14 Jul 2026 12:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0oUm2J
	fcr0108qecry6v9pejLzfJATbuNlStxoQmzvA=; b=svO3vhlJcDkocmV2IEXr6N
	j/5pf3aEi6qEAvY1eNDy9ql4leEta1o2gApeUVZg/uJrfNOKScdv+rhiy4CH2nEg
	FevHuIJqjgYSHO/vRU5FXUf37AL05cYmq0AsyrIFLFN5QhaE64slwNr1mKiIENKQ
	GP0ki1OoW5w8VhjKqt1OzkVPk9/S6dqxAT88lm68QFd0pHLDEEqN7pQ2QFq8uiK0
	ACVVqNpjdsUXuCnr1H8A7B6wS2LGVoa2D4EU0rPcvev4skV+YnuXrzbVvu84U1de
	yK/MkrUC7la+CbuQMfgWOslM5ZSnCiI5cwKiMQeeZWPHGxIjfSPvYXi6dPC6l9Jg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a5fjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 12:01:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBni8l023920;
	Tue, 14 Jul 2026 12:01:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy2a9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 12:01:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EC1s4X31851160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 12:01:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88B9020040;
	Tue, 14 Jul 2026 12:01:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 355E520049;
	Tue, 14 Jul 2026 12:01:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 12:01:54 +0000 (GMT)
Message-ID: <33187980-d8d8-43f4-a138-34c67fa63d8b@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:01:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/17] tests/tcg/s390x: Add tests for CPACF
 instructions
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-18-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710152906.80207-18-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfXzgqhbWhM37re
 zNqzRfSfUluOU9cANy9sbwA7qCyaIG3ml8ZXetj6nhw7vIXArbs465IaH6vEBdu0Ikzza75Rqh5
 sTetWbMgCNebo/QRGD1/usMzouMhA68=
X-Proofpoint-GUID: p3pPZrwt3-UDlf31IbCxsCK5Qap3MYLr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfXxIhoewyWOD/v
 +2TiafnqYQnBMdD6oAzYGBYJpIcaWeWrlUq2szMRL+erL0EgRlu3b/r5lMUZ8FayLJdfuxhjUwC
 8jo7cqAxTyVLLLp0vj5tW6kPAFh9Ky2BLdHfA994M0E0QYl1SBe/g4lTszochVPMbZAZnEYwe4n
 56sBEDBKEnZuX6JLgatwOmZiABge/4zI5ODZI6NxPiBqqgVSra5stJE6L17yzudyrUlrY5Rlc9w
 mYG/z+6iLbjMpPA1/RNqIgMjCfBU1zt1pcCluM1INCsNZFnGjLpbungEzUDX3D5IXZk4b8vVHdL
 ybxy8afo6n0gRVotoRJDXL98+Te6XdPCXDIFB8JBIdmlQ6Mi+gbr+0Ay1jtgzwCSCs17j967Cmq
 8ET3NYMLhE3QKUIdRAZ52EKkgclxbxDoPbBHL09P7jjWaO80PKIhPNdc5SDF1l2mmh1lFlGRym9
 yEY/V+jXGhn8MQQlt4A==
X-Proofpoint-ORIG-GUID: p3pPZrwt3-UDlf31IbCxsCK5Qap3MYLr
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a562537 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ow17IZp0XGAzbqrRrHkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140122
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
	TAGGED_FROM(0.00)[bounces-22222-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:from_mime,linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[iii@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iii@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 453837546F0



On 7/10/26 17:29, Harald Freudenberger wrote:
> Add simple tests for the CPACF instructions implemented:
> - kdsa - minimal as only query is implemented
> - kimd - query, sha256, sha512
> - klmd - query, sha256, sha512
> - km - query, aes 128, 192, 256 with clear and prot key
> - kmac - minimal as only query is implemented
> - kmc - query, aes 128, 192, 256 with clear and prot key
> - kmctr - query, aes 128, 192, 256 with clear and prot key
> - pcc - query, xts aes 128, 256 and prot key xts aes 128, 256
> - prno - query, trng
> No test for pckmo as this is a privileged instruction.
> No test for kma, kmf, kmo as these instructions are currently
> not implemented at all.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h        |   7 +
>   tests/tcg/s390x/Makefile.target |   9 +
>   tests/tcg/s390x/cpacf-kdsa.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kimd.c    | 166 +++++++++
>   tests/tcg/s390x/cpacf-klmd.c    | 206 +++++++++++
>   tests/tcg/s390x/cpacf-km.c      | 590 ++++++++++++++++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmac.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kmc.c     | 351 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmctr.c   | 360 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-pcc.c     | 245 +++++++++++++
>   tests/tcg/s390x/cpacf-prno.c    | 131 +++++++
>   tests/tcg/s390x/cpacf.h         | 571 +++++++++++++++++++++++++++++++
>   12 files changed, 2752 insertions(+)
>   create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
>   create mode 100644 tests/tcg/s390x/cpacf-kimd.c
>   create mode 100644 tests/tcg/s390x/cpacf-klmd.c
>   create mode 100644 tests/tcg/s390x/cpacf-km.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmac.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmc.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
>   create mode 100644 tests/tcg/s390x/cpacf-pcc.c
>   create mode 100644 tests/tcg/s390x/cpacf-prno.c
>   create mode 100644 tests/tcg/s390x/cpacf.h

I get failures when running these on a real z17, for example:

$ ./cpacf-kdsa
test_kdsa_query failed
cpacf-kdsa: 1 failures

