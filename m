Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5989A261581
	for <lists+linux-s390@lfdr.de>; Tue,  8 Sep 2020 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbgIHQv5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Sep 2020 12:51:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731719AbgIHQvu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 12:51:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088FWpHb171716;
        Tue, 8 Sep 2020 11:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZE+1EhFZPApaQ3SkZgij3eeFLeg8ZYl8QKvXMOibk88=;
 b=Hsc7CUzPcbzMB449ZNIyiwu7auIacUK/KbK57QmebxNxhUTWMsMygOWglxZtDXj+0i1y
 XFXY0irNoWjh4N6uPI59bbRUPSGcYoLJoYvnEm3IYo8E5MNPxj200xVqAqfLFukbblef
 uqyobHXmKZZoCfNzPOu562aVBVbHkmLnfTdo8+bqck8tZ99zVFcT0ZvJcOQ4SCgQQayF
 7DMEaQFZe2eZSI8PPdKcl4JON2SkPif+vx2CaGvcO3+OvnKrbAhlg5zakqh5hsyraTow
 Mpm6JF2rPq+tCf7fr9oiOMziws4rejNcMEUcXi+4qzVkD6/d1NtTQAoUue0+4KnUvZuA Iw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ecjvre0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 11:39:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 088FcDbR023147;
        Tue, 8 Sep 2020 15:39:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8bkja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 15:39:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 088Fd8vA32965056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Sep 2020 15:39:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 687F611C05C;
        Tue,  8 Sep 2020 15:39:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7B1F11C04A;
        Tue,  8 Sep 2020 15:39:07 +0000 (GMT)
Received: from thinkpad (unknown [9.171.25.197])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  8 Sep 2020 15:39:07 +0000 (GMT)
Date:   Tue, 8 Sep 2020 17:39:06 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: Re: [PATCH v4 00/13] mm/debug_vm_pgtable fixes
Message-ID: <20200908173906.30fffaa0@thinkpad>
In-Reply-To: <20200904180115.07ee5f00@thinkpad>
References: <20200902114222.181353-1-aneesh.kumar@linux.ibm.com>
        <bb0f3427-e2bd-f713-3ea8-d264be0e690b@arm.com>
        <20200904172647.002113d3@thinkpad>
        <20200904180115.07ee5f00@thinkpad>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_08:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 spamscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009080148
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 4 Sep 2020 18:01:15 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

[...]
> 
> BTW2, a quick test with this change (so far) made the issues on s390
> go away:
> 
> @@ -1069,7 +1074,7 @@ static int __init debug_vm_pgtable(void)
>         spin_unlock(ptl);
> 
>  #ifndef CONFIG_PPC_BOOK3S_64
> -       hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
> +       hugetlb_advanced_tests(mm, vma, (pte_t *) pmdp, pmd_aligned, vaddr, prot);
>  #endif
> 
>         spin_lock(&mm->page_table_lock);
> 
> That would more match the "pte_t pointer" usage for hugetlb code,
> i.e. just cast a pmd_t pointer to it. Also changed to pmd_aligned,
> but I think the root cause is the pte_t pointer.
> 
> Not entirely sure though if that would really be the correct fix.
> I somehow lost whatever little track I had about what these tests
> really want to check, and if that would still be valid with that
> change.

Uh oh, wasn't aware that this (or some predecessor) already went
upstream, and broke our debug kernel today.

I found out now what goes (horribly) wrong on s390, see below for
more details. In short, using hugetlb primitives with ptep pointers
that do _not_ point to a pmd or pud entry will not work on s390.
It also seems to make no sense to verify / test such a thing in general,
as it would also be a severe bug if any kernel code would do that.
After all, with hugepages, there are no pte tables, only pmd etc.
tables.

My change above would fix the issue for s390, but I can still not
completely judge if that would not break other things for your
tests. In general, for normal kernel code, much of what you do would
be very broken, but I guess your tests are doing such "special" things
because they can. E.g. because they operate on some "sandbox" mm
and page tables, and you also do not need properly populated page
tables for some exit / free cleanup, you just throw them away
explicitly with pXd_free at the end. So it might just be "the right
thing" to pass a casted pmd pointer to hugetlb_advanced_tests(),
to simulate and test (proper) usage of the hugetlb primitives.
I also see no other way to make this work for s390, than using a
proper pmd/pud pointer. If not possible, please add us to the
#ifndef.

So, for all those interested, here is what goes wrong on s390.
huge_ptep_get_and_clear() uses the "idte" instruction for the
clearing (and TLB invalidation) part. That instruction expects
a "region or segment table" origin, which is a pmd/pud/p4d/pgd,
but not a pte table. Even worse, when we calculate the table
origin from the given ptep (which *should* not point to a pte),
due to different table sizes for pte / pXd tables, we end up
at some place before the given pte table.

The "idte" instruction also gets the virtual address, and does
corresponding index addition to the given table origin. Depending
on the pmd_index we now end up either within the pte table again,
in which case we see a panic because idte complains about seeing
a pte value. If we are unlucky, then we end up outside the pte
table, and depending on the content of that memory location, idte
might succeed, effectively corrupting that memory.

That explains why we only see the panic sometimes, depending on
random vaddr, other symptoms other times, and probably completely
silent memory corruption for the rest...
