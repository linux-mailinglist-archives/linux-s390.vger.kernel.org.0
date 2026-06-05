Return-Path: <linux-s390+bounces-20556-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j1WSBViuImpNcAEAu9opvQ
	(envelope-from <linux-s390+bounces-20556-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 13:09:12 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6BC647A07
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 13:09:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=ZQ+no+Uj;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20556-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20556-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598493024121
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8444C957C;
	Fri,  5 Jun 2026 11:02:09 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712633E51D3;
	Fri,  5 Jun 2026 11:02:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657328; cv=none; b=nn8xRqivTIhBAx1fzZzLK/f9ENhYgRxCBRmfaFgNXaZHwcpm/siHMFWy14C9er6kmKFUTLNiY3fEl/M9kK3ysebrNf1Ivlew319eqf2xVSclnmm4Yycj2g1qlF0dQBzJ/72nMq4CK4oxeX6XEFxO6wP2RnBPEEPvG8jgH2+NnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657328; c=relaxed/simple;
	bh=9EHPs7SnjuoBA6rvdefrG2XYtJ6c/JCGYlMiwvf3YYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUsLppJuD6WbDv8/dfsUmgHGnEWHpGQe2uCf6Y2k+ow1iUxsC0+jZ1AzdjZKtoBsNVdd9AqDnGwCUgpjPHRcSZEGAL0ecKk9Z/Q/hPyDf16MiM/kXDj98H8E638tZyu3E1/6BMW+l+uYwb5D1s+UrBdIwqGg+gF/y2aezAeF2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZQ+no+Uj; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654NVrVw1640981;
	Fri, 5 Jun 2026 11:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/+TOBB
	ktSdBVCNKtWg9fVO1y83PdPIgT7Shk0FfOPXw=; b=ZQ+no+UjCvQduZ8wG+vinw
	mZIwAb7KJTr4nypONOs9zMZkGTXZuHEdnST5kAYuKVX+nNmQm9enaRGevExzVULl
	x4h6VFu6LE4FtRhL4MDS0KZ5zHGH0KYZlxOeqsigpAwT5xZ1kHfRRmpevG6hFSEl
	Q5Q1evemImWyi7AQNlDaGrzmh6uPIE6UNq9X6u6ILqCpsYtwG5tbvXuL80hSY8py
	DqgaDYYuuNlhrbq+ywklHZGYJjRk/+fO2JJ04X0JM3c/CTowKCY6Iv3/k/evH1nG
	J/0ZYKTkED0f2CYcOZZEG5PxZJ51wYaBvs/SLcUYKNpxmvsUmF1RqadxG92Y+JKg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnaj3k05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 11:01:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655AsAXk017079;
	Fri, 5 Jun 2026 11:01:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwys0am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 11:01:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655B1biJ61276644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 11:01:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CFFC20040;
	Fri,  5 Jun 2026 11:01:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1276620043;
	Fri,  5 Jun 2026 11:01:36 +0000 (GMT)
Received: from [9.111.29.71] (unknown [9.111.29.71])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 11:01:35 +0000 (GMT)
Message-ID: <078b0276-4458-4320-b35f-f8802720f886@linux.ibm.com>
Date: Fri, 5 Jun 2026 12:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Douglas Freimuth <freimuth@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, clrkwllms@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Marco Crivellari <marco.crivellari@suse.com>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
 <a7180379-04f5-4f61-b60a-0ff7cf85134d@linux.ibm.com>
 <ec3987e3-4eb7-4d07-be9e-bd8dc9ad176f@linux.ibm.com>
 <08307223-88ad-4550-963e-5d1ee315023c@linux.ibm.com>
 <a3bbf315-536f-429e-afb2-adcbf508a66f@linux.ibm.com>
 <20260303115235.GQ1282955@noisy.programming.kicks-ass.net>
 <6c3fbb6d-d4e1-4984-b584-c067be844098@linux.ibm.com>
 <20260605105211.rZ8x7Hd5@linutronix.de>
Content-Language: en-GB
From: Ciunas Bennett <ciunas@linux.ibm.com>
In-Reply-To: <20260605105211.rZ8x7Hd5@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDEwMyBTYWx0ZWRfXyayp2yInpsQY
 v6zWKD3bB28Gz9Epq0D/QiF22S9fSUd3OU9iF0vnT50dnRi0/oNMlSUr8qeH13tYJ9fk/U4b6dr
 PgJiUdLRl05xt0+bFQk/gLkBwBgSwk3J1pQxEep7JgTz9dRLc52MLqmL55rmSIBzMiq29hSERE/
 qA74QP1zaqNRkVAHo8T3wbhcusjrRI2LBGIIwwTThjlA+1z1z+ncwidvWNYAotRc3Zw+hpMPITN
 kd+vlgxhQx6kvYHhvZMVWXNu/20I5iTDEoSKy+hxbOOIE8CWq4IiT1XpAJ7vUu1gQwz7mGTpp0j
 gxKifsBE+9+BASzR8lnujIL9dEArMH+1AtQyg4PdWCIJmslpp19tllnhyeKzwBl9kAt8DXgaDvP
 yqNgPwpkO4n0t28OPWCB8LKRjAHqzsDtxPHA54uu0nzkxQ4iapjMD0/cZ7zhFZtkL+cCg3ME7Ld
 aMzyglPqs8enscpm4hg==
X-Proofpoint-ORIG-GUID: pli3czyyzOmgaO2JdJ7PPgBFCp7pJ855
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a22ac98 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ACxPka3VRXSE_1752UsA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 4BrJN-HU9S0WlB8qvKXpJJw11YyeJZhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050103
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
	TAGGED_FROM(0.00)[bounces-20556-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:peterz@infradead.org,m:freimuth@linux.ibm.com,m:borntraeger@linux.ibm.com,m:iii@linux.ibm.com,m:mingo@kernel.org,m:tglx@linutronix.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:clrkwllms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:torvalds@linux-foundation.org,m:linux-s390@vger.kernel.org,m:mjrosato@linux.ibm.com,m:brueckner@linux.ibm.com,m:marco.crivellari@suse.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:from_mime,linux.ibm.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[ciunas@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ciunas@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D6BC647A07


>> delayed significantly before it gets CPU time.
> 
> There is some work done by Marco to rework the API to explicitly state
> if a per-CPU workqueue is mandatory _or_ if an CPU unbound workqueue can
> be used instead. (Rather than having schedule_work() not knowing the
> implications).

Oh, that is good some work already being done here.
I had a small patch ready to go, but possibly the solution needs to be more robust.
-            schedule_work(&irqfd->inject);
+            queue_work(system_dfl_wq, &irqfd->inject);


> It seems that using an unbound worker would avoid the problem at hand,
> correct?
> 
> Sebastian

Yeah, changing to an unbound kworker avoids the issue in any of the testing I have done.
Ciunas

