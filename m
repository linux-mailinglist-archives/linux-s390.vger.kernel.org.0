Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6633E2344DB
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jul 2020 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbgGaLwp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 31 Jul 2020 07:52:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6314 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732690AbgGaLwp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 07:52:45 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VBWwbk067877;
        Fri, 31 Jul 2020 07:52:33 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32md200pwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 07:52:32 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VBkT35025791;
        Fri, 31 Jul 2020 11:52:31 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 32gcqgq6un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 11:52:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VBqSKM61735376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 11:52:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54AC2A4057;
        Fri, 31 Jul 2020 11:52:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED0EDA4051;
        Fri, 31 Jul 2020 11:52:27 +0000 (GMT)
Received: from osiris (unknown [9.171.43.11])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 31 Jul 2020 11:52:27 +0000 (GMT)
Date:   Fri, 31 Jul 2020 13:52:26 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Wang Hai <wanghai38@huawei.com>, gor@linux.ibm.com,
        borntraeger@de.ibm.com, colin.king@canonical.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/test_unwind: fix possible memleak in test_unwind()
Message-ID: <20200731115226.GD11581@osiris>
References: <20200730063602.31581-1-wanghai38@huawei.com>
 <247044acbf1dbae8e3b48c2dcc1457cd2e59cfef.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247044acbf1dbae8e3b48c2dcc1457cd2e59cfef.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 mlxlogscore=777
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310088
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 30, 2020 at 09:35:15AM +0200, Ilya Leoshkevich wrote:
> On Thu, 2020-07-30 at 14:36 +0800, Wang Hai wrote:
> > test_unwind() misses to call kfree(bt) in an error path.
> > Add the missed function call to fix it.
> > 
> > Fixes: 0610154650f1 ("s390/test_unwind: print verbose unwinding
> > results")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > ---
> >  arch/s390/lib/test_unwind.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/lib/test_unwind.c
> > b/arch/s390/lib/test_unwind.c
> > index 32b7a30b2485..b0b12b46bc57 100644
> > --- a/arch/s390/lib/test_unwind.c
> > +++ b/arch/s390/lib/test_unwind.c
> > @@ -63,6 +63,7 @@ static noinline int test_unwind(struct task_struct
> > *task, struct pt_regs *regs,
> >  			break;
> >  		if (state.reliable && !addr) {
> >  			pr_err("unwind state reliable but addr is
> > 0\n");
> > +			kfree(bt);
> >  			return -EINVAL;
> >  		}
> >  		sprint_symbol(sym, addr);
> 
> Looks good to me, thanks!
> 
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
