Return-Path: <linux-s390+bounces-20650-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iplTDDrwJ2rc5wIAu9opvQ
	(envelope-from <linux-s390+bounces-20650-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 12:51:38 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CC765F25A
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 12:51:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=FHHvcOzC;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20650-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20650-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26AB63000897
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FFA2BE642;
	Tue,  9 Jun 2026 10:39:19 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B733A71B;
	Tue,  9 Jun 2026 10:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001559; cv=none; b=D7+25ccqEPxFYBLpbh03IZ85XKv1uH294th7e9T+zpuv5i9by7a7ZWIf9zduGE03pogpUOadQmzlwk5XjyKiz1RVlgjILb3sCSX0ameZYlWzkPaaXlGdWJZuw7DIobolIWd38NcRNXjZq+tzaxM3Xooe7K7iMhp07gVAkTdAU7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001559; c=relaxed/simple;
	bh=YJuGyxEVhtQlpHoi7j8wR6XD1RU5IQ4Dw34l64Ipd6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWMmA5NAicANDHji2ZBNjF+TUvq+CF0yzKr4rYxheGbO56CNUvObXYc8VPSrX8wBQfZNckuUDkVKGWzRE13vageaYuq/9cAWtXXUpY3iG0blcV/MRf6ggjTLbgLCOcPRER4W5Sd/ujxE/Lh94Ul5/r27DhVnmBdh/6zAyLfi2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FHHvcOzC; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Nkh5d2909046;
	Tue, 9 Jun 2026 10:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=W/rdTQd8YqP4xY3UGyFBuxsHBPrcJR
	n1D4+FE6FlBlA=; b=FHHvcOzC8v96L5Ir/LxKqE1+7Q6OulPYG9g8z3wE7YwkQs
	ELco2dTAO68vfZC9+SYJCotVII95dxINWn8HHBB2lCrj8dzG5pz/Z4gVzCYH/NeT
	fBd2mX3V8+RL1mDV5SOFID1+tA18dg5kFpUFPLiV8+vaedS9Gol4sigsaWyyO5Sh
	45h7WSAviFUVPwu2AMJ8P4CkGCkmGcr22u/tUJ+QZguk8/n6WpXgHNTdvvXcARki
	KHFZ0qeRbYaFquygNSwhIW0rSUgJysl5ucuFsj+Yew+ELrYowZiAevGGJgMsA3xl
	0DY3nJdVdK6xnx0rkMAPb7X1JkEOLFy3rHzvWaMQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23uq8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 10:39:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659AYc5b024211;
	Tue, 9 Jun 2026 10:39:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq1qpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 10:39:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659Ad6uK48824718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 10:39:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63C420040;
	Tue,  9 Jun 2026 10:39:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14CBB20043;
	Tue,  9 Jun 2026 10:39:06 +0000 (GMT)
Received: from osiris (unknown [9.111.52.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 10:39:06 +0000 (GMT)
Date: Tue, 9 Jun 2026 12:39:04 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] s390/tick: Remove CIF_NOHZ_DELAY flag
Message-ID: <20260609103904.9217Afa-hca@linux.ibm.com>
References: <20260609075213.31094-1-meted@linux.ibm.com>
 <20260609075213.31094-2-meted@linux.ibm.com>
 <e70007af-aa98-4870-985a-6648564127fd@arm.com>
 <7d2ace86-f355-4ff7-886b-7963574b2202@linux.ibm.com>
 <dece845e-12df-4aa0-b515-a41458bfbae3@arm.com>
 <b2b8cf98-bc41-43b6-838b-60822a9a4c89@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b8cf98-bc41-43b6-838b-60822a9a4c89@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a27ed4f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8kDfDS3PkAXohz4YEQsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QQVKhxUyD4uxvOfnfSqUDHAMUpOs-KnI
X-Proofpoint-GUID: QQVKhxUyD4uxvOfnfSqUDHAMUpOs-KnI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5OSBTYWx0ZWRfX/zDG9PyFBniz
 gnzJ8xP2ouoGYNlThSkuxN9Y/qDd3X2N2IZwuZ6dukD4udZhs5yQHwEqTNDy2X177L/44waTgRs
 fCkWVUfCfUti4cPY0BEDdPNMDJmI3AxbZYcSjL0KgTGqA48Vqu5Db68BdwBCn/KQg7yiWDpUT4f
 PW4+RiJNTdsbDX/hq6ouGAoSJXcsB6Z4Ugd8kZfNh693WQMcFxbdl8/dEOktvbqzNSEYedCICw2
 Rc9WHHyDcyGq/m4rv2pf/JJm21UJ/Begvo08/XcnCy7SO4vXEu2xCcIE5AZ/+R/rX50lRxkSMMl
 4lUc/q0e5GdSKlDEKCpRWqDe6go0sFmusVh/+vmjnulZiHg4ryuqZHrc1RhSnqW6GNgqCliG0EC
 tme/6BbAszqzgVtxV6949mjKegJvRqhJzHXzVLcaOqpXgDHABlcB9G9kAPxObuHu37yBAQ3znqp
 tHGDHohkWlPhUcX+7Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20650-lists,linux-s390=lfdr.de];
	TO_DN_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:meted@linux.ibm.com,m:christian.loehle@arm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:tglx@kernel.org,m:iii@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23CC765F25A

On Tue, Jun 09, 2026 at 12:04:08PM +0200, Mete Durlu wrote:
> On 6/9/26 11:52, Christian Loehle wrote:
> > > > > Remove obsolete tick delay heuristic [1]. The upcoming cpuidle driver
> > > > > handles frequent sleep/wakeup cycles more effectively.
> > > > > 
> > > > > [1] https://lore.kernel.org/all/20090929122533.402715150@de.ibm.com/
> > > > > 
> > > > > Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> > > > > Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> > > > > ---
> > > > For bisectibility does it make sense to move this and 2/5 to the end?
> > > 
> > > I am unable to see how that would help. Could you elaborate?
> > 
> > CIF_NOHZ_DELAY is only obsolete because of the new s390 cpuidle driver
> > handles NOHZ better overall right?
> > So my suggestion was to only obsolete it once everything is in place?
> 
> CIF_NOHZ_DELAY could modify the idle driver's decisions when it comes to
> disabling the scheduling tick. It could be hard to bisect a problem with
> the driver if we move the removal of the flag after the drivers
> introduction. Because then the commit that enables the driver can have
> a significantly different behavior.
> 
> Plus,having the flag obsolete without any other mechanism doing a
> similar job would make the effect and related behavior more visible and
> easier to debug.

The flag is questionable since a long time. So I wouldn't focus on the
question if the removal comes at the beginning or end of this series.
I'm more than happy to see it go.

