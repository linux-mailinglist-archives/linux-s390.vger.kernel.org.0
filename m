Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450172AD420
	for <lists+linux-s390@lfdr.de>; Tue, 10 Nov 2020 11:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKJKvC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 10 Nov 2020 05:51:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgKJKvC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 05:51:02 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAAWLuP134938
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 05:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zeJu/KC40UE4wcbfkrnifenY/XPvjsQzl/VFWEuZ1WQ=;
 b=K5M264xmwuloY8DzJMyF/qXUm4+/fqhYYwvbKb/alEZUVo49eu4G3G4uA8o7v0hrBZ5l
 cylY1ZRfoJtZ/TfNBt93zHS8tKKESCue44DsYrUokum68pXzdr/jomMpez0/nlwhfJIg
 TuuY6Qad/AJF2KUPpCnTWASXUu0NO9w6q4udacm5me1GrhiCLCjQcJTuf908cdcsHMu7
 peMPQD0Zkz680aPHXoSTYU20pIdTOIbNXjg2JfORqdV21BGOU13M9Hvf05F1bUDhzGXj
 3BsK+FnOoZM555hQEW6OBslwkUBz3xFuLtqtgNaOgVu95FbAqykUcgiXq5OuScy641k5 kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qpjrn8cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 05:51:01 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AAAWW09135475
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 05:51:01 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qpjrn8bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 05:51:00 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AAAlfZg006504;
        Tue, 10 Nov 2020 10:50:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 34nk781j46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 10:50:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AAAosnf54591790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 10:50:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 943C042045;
        Tue, 10 Nov 2020 10:50:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 548AF42047;
        Tue, 10 Nov 2020 10:50:54 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.174.65])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 10 Nov 2020 10:50:54 +0000 (GMT)
Date:   Tue, 10 Nov 2020 11:50:52 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/vmem: fix possible memory overwrite
Message-ID: <20201110105052.GA11672@oc3871087118.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
 <aec7d80c-a7a1-d3db-9719-1ca69fb80887@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7d80c-a7a1-d3db-9719-1ca69fb80887@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-05,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=983 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011100071
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 10, 2020 at 10:41:14AM +0100, David Hildenbrand wrote:
> On 10.11.20 10:36, Alexander Gordeev wrote:
> >If for whatever reason the sub-PMD region to be used is less
> >than struct page size (e.g in the future), then it is possible
> >to overwrite beyond the region size.
> >
> >Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> >---
> >  arch/s390/mm/vmem.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> >index 56ab9bb770f3a..d7f25884061f4 100644
> >--- a/arch/s390/mm/vmem.c
> >+++ b/arch/s390/mm/vmem.c
> >@@ -91,13 +91,15 @@ static void vmemmap_flush_unused_pmd(void)
> >  static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> >  {
> >+	unsigned long size = min(end - start, sizeof(struct page));
> >+
> >  	/*
> >  	 * As we expect to add in the same granularity as we remove, it's
> >  	 * sufficient to mark only some piece used to block the memmap page from
> >  	 * getting removed (just in case the memmap never gets initialized,
> >  	 * e.g., because the memory block never gets onlined).
> >  	 */
> >-	memset(__va(start), 0, sizeof(struct page));
> >+	memset(__va(start), 0, size);
> >  }
> >  static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> >
> 
> I don't really see a need for that. Can you spell out one possible
> configuration that would trigger that in the future? It's sounds
> very unlikely and I have the feeling there might be more to change
> at other points.

No configuration in mind. But dependency on struct page is the only
obstacle that prevents the whole thing to become generic (unless I
am missing something). Moreover, the memset() would not be needed
also - just a single non-PAGE_UNUSED word within [start..end) should
be enough.

> -- 
> Thanks,
> 
> David / dhildenb
> 
