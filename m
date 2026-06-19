Return-Path: <linux-s390+bounces-21043-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7s14NXIpNWoQnwYAu9opvQ
	(envelope-from <linux-s390+bounces-21043-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 13:35:14 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FBA6A5706
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 13:35:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=DmvJipSM;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21043-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21043-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA4BC3009144
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE8C24B28;
	Fri, 19 Jun 2026 11:35:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E6233927;
	Fri, 19 Jun 2026 11:35:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868912; cv=none; b=iE4Ce51visIHX5OJDDXUPah0RoLhbhOtBaCUSz0BwauO1eGm9Em7CfXBnm1uk+JE8t12WdIgKFL/VwkZbb8LyP5KaHJ1aKI3Q3YzELnhVNw1cMMJMset0MJg1qFyHzXcaurW2g8uBTKbMU7NKEUA9tpRBnUbWMKbTaUrMYLYbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868912; c=relaxed/simple;
	bh=mp4IXtfIScMfTZP+RqaGeIb1+pwKdzCTirGwNVxAa5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2aZDViAPqhjlucbgsXa0lFCP2HVi44ORar71xF6jPeHpOr6WMJWpsSmHbilfTAh3fgxmL8zkAaMa3iOl0+jCI/N/RXNMlJzuibtk8yip0/0RmPMBoVhtO+zO7JbpuKeUtwrDaqg/AXIH8InGwfxJpP10ntKRWKle7mPRZwA5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DmvJipSM; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mQid1674571;
	Fri, 19 Jun 2026 11:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hH8UXBJCfiqjKuLT+/4wZr7f68YEUl
	8G3pP4WO3Tgzg=; b=DmvJipSMlWUV/h8wpzzTrnLV7YRMlWROPgMAaCMpAT41zO
	z2Npm6pQxcAFYuTwtKzyaUlTVQl4VnIgBf5P7lvBO9UJ7L/h0a0g5sR45RBIS22Y
	sV9s4wAXpoIeMCwGReRSNQE1XDuZ3Bi8AC42VAnJYD18JjKTBhXM2u95Qs1G3A6n
	vrsu6laVjU1vOmiGDvH6AiGiLv023ZdQZpHXVfr7Q3bw4TOJ2VywwweJw4lf/MS3
	/MdabNbyRlpOsPCQHaryyjf7PS53lQOPuQqplIH5bNEzYLb7QSphNh0+4V/4Tmun
	HXOR5IrXflk0Nmq9E3KIREzhAO6gDu6Y1ZFccBeQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw59sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 11:35:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JBYtgX007135;
	Fri, 19 Jun 2026 11:35:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1728jse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 11:35:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JBYxi048759162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 11:34:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 766D120043;
	Fri, 19 Jun 2026 11:34:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F24E20040;
	Fri, 19 Jun 2026 11:34:59 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 11:34:59 +0000 (GMT)
Date: Fri, 19 Jun 2026 13:34:58 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/5] s390/idle: CPU idle driver
Message-ID: <09172d0f-e0d4-48c0-9504-698981de5495-agordeev@linux.ibm.com>
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <e624cd2b-9b07-4e7e-bab3-0cf73e9f9db9-agordeev@linux.ibm.com>
 <749b0206-f2d5-44dc-b95b-5ade0bf3801a@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749b0206-f2d5-44dc-b95b-5ade0bf3801a@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNSBTYWx0ZWRfX1CVZ07T743QH
 xLFrGBAgDW7P81DxOPBaxyTAsU2hNa3UgdysFwaw180YLmaFvFjX+nKQKeXxvSbAeMES05P4yPN
 YA+ekGMDIjmkIW9QzLbkcsc5RxB84k4=
X-Proofpoint-GUID: FUs46UUIa9JrtYPSK2VmdAbnlqVaVNjm
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a352968 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=h2WtxV9Ns-pZZfJurkwA:9
 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: FUs46UUIa9JrtYPSK2VmdAbnlqVaVNjm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNSBTYWx0ZWRfX9L8kJ3fLjSfa
 jVPw+CvEJjtoKoGRThlTkK8t+5ROUjwYRLWbkBpoaKzlg8YuvfprikrbgM8w81DCvdQHvyuHHa6
 Rx/dDhex2LKbH2pUWDhhNlRPyIKZRhD010TzZ+qcSdmBth3siphQsiFtPalB225KLjVUfAgsAPw
 uBN5ORh7DK2GXlDvT5u2xPLsthHjWCwgHMIceNA4vgr/RARjqqLuxFEt4EQdLnS/S1dvGpEpSNF
 7MmEGZIHqaMN9P551owXyjrDjBzKXedVgy44EsBWVinurJYy7qLqoxQX4HTuulPgabYiFP6oJ4m
 e4sUMTx1LseRjSD3DMqnJHkjMCnhcZHUHX5HdQCGGABnpJ1HGSDvswFUk47KvXqPm4FUCpHmuI8
 u1TIxsv6CAKylXMqRWb/UbCMsT2vzeqy4gIVIatzBQPYkYSnlgKwJPxMYuw4px1xAmhC0YubaQg
 cJi71eYkpB1C2VqxyTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21043-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:christian.loehle@arm.com,m:meted@linux.ibm.com,m:rafael@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:svens@linux.ibm.com,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:tglx@kernel.org,m:daniel.lezcano@kernel.org,m:borntraeger@linux.ibm.com,m:iii@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[agordeev@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agordeev@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71FBA6A5706

On Fri, Jun 19, 2026 at 11:38:07AM +0100, Christian Loehle wrote:
> > Applied, thanks!
> 
> All of it? Rafael should probably at least ack drivers/cpuidle/* things...

I assumed your R-b is enough, but I will hold this series until
Rafael or Daniel have a look then.

Thanks!

