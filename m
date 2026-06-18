Return-Path: <linux-s390+bounces-20968-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pv09A/KBM2ogDAYAu9opvQ
	(envelope-from <linux-s390+bounces-20968-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 07:28:18 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD069DB34
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 07:28:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=IjthPHJI;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20968-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20968-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E80B3300F626
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 05:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FE437F8B6;
	Thu, 18 Jun 2026 05:28:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ADC257854
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 05:28:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781760492; cv=none; b=D1YdlZYW+iKZCns9zk8FKDcIJYMMFcM5Bgc9GTLQNTi48kxZN1yPN0pZ1amtD+jSZiCNLdegAjAFmuaFS/oV4u3OkQLU8LTy3vsUI3/yJcKyNGZ7jHBjU1WIWn/0ojNe3Sbish5PXBTiGQUjj9n+BCCfNJ5A49XaDSqXKhRzeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781760492; c=relaxed/simple;
	bh=AtOC/vO/XTRoJgB5rtkZrBWenDd5H4dzGUbI+2lNc4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWYYO1+e+Vez6z8jdYuJHWwTpmY7x6EKezXOIiI2oKuLajG5CLZh7A7IRDu0NAGXxTgSXPS4EgrriUc1/6qTOrbxWqBp2zT3PX41Bz38FfCVhZq+/q/VlqJxNn5rQejHYMxW0HxfVD6ICDQCSy8boXQ6RCIotW2ylGffGaoPIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjthPHJI; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmSjE1016699;
	Thu, 18 Jun 2026 05:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b9WQ60
	JrOC4V6Q4tg4K0syYqicrLUgfc74foW+GuLGA=; b=IjthPHJI6hEX+4+kkr2hiF
	NNEBnZPGR+fILg596kjdmVvAXGvsq0Zfe9lWokvyQRG59vd45b2ujsp2J+ox7OHR
	tMhBfUkKaF+4fIdPCmPIPVb1M9GHjJzFBPoxeokdm+8VFLBA2VdXE5ApIEnxfm0C
	CBT8gQwGpFTLpSfXX7Kk1m9y/gOs5HVAdEPBPKdXdtzms6UOoYZPeqHhvLcDXfoa
	XSfxNVFdk7aCLg4ECDf+e3eDja7uV5EVWiU1nwLv+LP7vcngKgWnCWoxI4OBlFb5
	1VSWTI9xdN2pak0gIVogETCQqWtA22/K2BUwy+t5ZGL9PFxG1LlhIPVVD/mgxP+g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxec3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:28:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5JfDB021428;
	Thu, 18 Jun 2026 05:28:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a4uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:28:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I5RvKu44368382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 05:27:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 821BE2004B;
	Thu, 18 Jun 2026 05:27:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5129020043;
	Thu, 18 Jun 2026 05:27:57 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 05:27:57 +0000 (GMT)
Message-ID: <1aa7085b-9e33-4165-951f-fc93ad85c8ab@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:27:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/17] target/s390x: Support AES CBC for cpacf kmc
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
 <20260617094820.34402-6-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a3381e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=QxsEGm3-VmKSLUQtJqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX59Gkdm2Iot+Q
 hxx1fuitqTYGpuSRU7JOMI30lBsh9BprTgIT+KzPQIN6RDK7lHx5oj5EhYEvuCyk7qjjdmIPkfz
 XeTt0BkSEFsEddNZ0u7AD0dKLDIg39yu4fw5u8U0sZbaqWysNVvcb6bVV+IiEQ0uWnmbk5hkHni
 DWBZLZWlfTrsoQb9CKflgezDsgupmqsKkTvOgk6X6q/XNPVcMXch/0G6tgzyQvZWxHRJBf68RQP
 R/tDjkY8ZbXBgE76s7hjaMWdKueIRx4cbEZkvOShSW7+IMoaKd7BNmv0Pk2TVNMmMCwfaZgi+MP
 OI8uhs2iDwnFnkFZ8qUMB4DiQas/ovaoxyBsfUysgLaqVRgtZULADIlhrTPpT4bvs1Eb6DA5yIe
 1I1cAv+pPXXu58PuDTIviMjprGleaHEgME4mpgaO25witZ6BQeG0YMW/XU8W9NhnkGo5ufHoWmD
 2QTHRAEe3nqvbOyELxQ==
X-Proofpoint-GUID: 4OZqH9iT71fNLPxVd5grIWR0UFAbOE-v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX6T5JNLEGqIlp
 kRHuNmL3V25FI1lhKp9mSXQS59jDK8+ULEXAM8UUAZhCflzz1nxjIS+JbzFcS9/cqQJTOt46qR0
 RTwcJrMzGmSfRjDqv2ESOqins812G9c=
X-Proofpoint-ORIG-GUID: 4OZqH9iT71fNLPxVd5grIWR0UFAbOE-v
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20968-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[fcallies@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: D3CD069DB34



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KMC_AES_128, CPACF_KMC_AES_192
> and CPACF_KMC_AES_256 for the cpacf kmc instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |   3 +
>   target/s390x/tcg/cpacf.h         |   4 ++
>   target/s390x/tcg/cpacf_aes.c     | 102 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  24 ++++++++
>   4 files changed, 133 insertions(+)
[ snip ]

