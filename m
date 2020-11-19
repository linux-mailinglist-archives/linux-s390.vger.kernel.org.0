Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33712B8C86
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 08:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgKSHpR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 02:45:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgKSHpR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:45:17 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7ViJL193975;
        Thu, 19 Nov 2020 02:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T5cSRXrA9+JzX/yxWrEeiDiG9niPEiUbkLzw8JiTsaU=;
 b=Rv2yHyz9hBePjSTEMXl5wfFqNvScStd7LRbj/GOPbVE6fXWb2QSr0skxqUenF5c4XOiI
 vwZ79cNz+p2kQDUe0Ej7KCDhcWUOBaQoRd3HsLB/f83uQIIWj26dK4Z5xjiTDeeoQh6L
 8sui1Eft7uepnBl6AFEfnI7oQMGp0cCwpH/iH4bvAnW0+QtKnAjFp0/CLy4SxfrdLBuA
 KxU8GtZS6S38I+9FphJQ+3HfRhNj8iBRtxnh5m58qz9csr2Ti4Bwf9uTQBWvvykXcZjY
 SbprPHB8163pcW9EhOyhjVDjhIYUnMvX+O3c4IFUxZIGEmuyKp707L1ECyOHN9/Be5rD oA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34wg5v6egt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 02:45:14 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ7gEUn026242;
        Thu, 19 Nov 2020 07:45:12 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 34t6v8bb3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 07:45:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AJ7j92B7995996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 07:45:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B23545206C;
        Thu, 19 Nov 2020 07:45:09 +0000 (GMT)
Received: from [9.145.53.92] (unknown [9.145.53.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1AA9452078;
        Thu, 19 Nov 2020 07:45:09 +0000 (GMT)
Subject: Re: [PATCH 1/6] s390/ctcm: Put struct th_header and th_sweep on
 stack.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-s390@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-2-bigeasy@linutronix.de>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <88ac2454-32f4-f48b-f255-b23aedabc45b@linux.ibm.com>
Date:   Thu, 19 Nov 2020 09:45:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_03:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=2 malwarescore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190050
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> The size of struct th_header is 8 byte and the size of struct th_sweep
> is 16 byte. The memory for is allocated, initialized, used and
> deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and keeping the
> variable on stack. Especially since the compiler is smart enough to not
> allocate the memory on stack but assign the values directly.
> 
> Declare struct th_sweep/th_header on stack and initialize it to zero.
> Use the local variable instead of the pointer.
> 

Frankly, I'd much rather see us use the pointers that are returned from
skb_push() and skb_put(). No need for the on-stack & memcpy indirection.
