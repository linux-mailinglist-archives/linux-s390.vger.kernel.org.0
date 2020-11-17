Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA52B6DA6
	for <lists+linux-s390@lfdr.de>; Tue, 17 Nov 2020 19:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKQSoa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 17 Nov 2020 13:44:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgKQSo3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 13:44:29 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIWPIt189177
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=c6tHRUHO2hv02Na6r8LD7ZGZtsmuAP26xNSmvd6bIc8=;
 b=CCjUVmf6uFP5z3+ITMOsJ1PzJZ+8BA+KFbjW/ZS80Ppu56ef+AQ3rAi37cdqr3QGsrl3
 oRBXAHxrai7XpV6ln6uNuUdQZxENCxAMRAeqghYO27rWk+mrrsV2Zksu7cSfPewrm1IO
 8YXw7clVfH/9ffe+/JmAPxajzf+LolV2VldRHQVidQhdCvm42jt7mEvNDwitLh4qD469
 pVbClJif0/YPBQlSnlGOhVhHs+meRSvvfJ6RYUzjoOKp2SLXu/RlGRnf7odzWj9n+prh
 VxpCjCZN1wrdMjVt9jeP9i6Xz0m11Fd1YZQnhbWbDtw3EPXdouzdWSrw3Rg/D0z8lmlZ uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vd6hxqg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:29 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AHIWoLT192978
        for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2020 13:44:29 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vd6hxqf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 13:44:28 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIh97j017632;
        Tue, 17 Nov 2020 18:44:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8bce6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 18:44:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AHIiOlR60031308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 18:44:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E911AAE053;
        Tue, 17 Nov 2020 18:44:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA439AE04D;
        Tue, 17 Nov 2020 18:44:23 +0000 (GMT)
Received: from osiris (unknown [9.171.25.24])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 17 Nov 2020 18:44:23 +0000 (GMT)
Date:   Tue, 17 Nov 2020 19:44:22 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/3] s390/vmem: fix possible memory overwrite
Message-ID: <20201117184422.GE4746@osiris>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
 <aec7d80c-a7a1-d3db-9719-1ca69fb80887@redhat.com>
 <20201110105052.GA11672@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110105052.GA11672@oc3871087118.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=1 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=818
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170131
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 10, 2020 at 11:50:52AM +0100, Alexander Gordeev wrote:
> > >  static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> > >  {
> > >+	unsigned long size = min(end - start, sizeof(struct page));
> > >+
> > >  	/*
> > >  	 * As we expect to add in the same granularity as we remove, it's
> > >  	 * sufficient to mark only some piece used to block the memmap page from
> > >  	 * getting removed (just in case the memmap never gets initialized,
> > >  	 * e.g., because the memory block never gets onlined).
> > >  	 */
> > >-	memset(__va(start), 0, sizeof(struct page));
> > >+	memset(__va(start), 0, size);
> > >  }
> > >  static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> > >
> > 
> > I don't really see a need for that. Can you spell out one possible
> > configuration that would trigger that in the future? It's sounds
> > very unlikely and I have the feeling there might be more to change
> > at other points.
> 
> No configuration in mind. But dependency on struct page is the only
> obstacle that prevents the whole thing to become generic (unless I
> am missing something). Moreover, the memset() would not be needed
> also - just a single non-PAGE_UNUSED word within [start..end) should
> be enough.

Well, I agree with David here - so not applying.
