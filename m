Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA207142BF2
	for <lists+linux-s390@lfdr.de>; Mon, 20 Jan 2020 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATNRC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Jan 2020 08:17:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36977 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726619AbgATNRC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jan 2020 08:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579526221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=YENVIhCXyucAIo1/lR79P7Lpgyy8CZMCenzpxlywS5U=;
        b=PjQn3xMut9/i833NydZroGJp6/3y0aDTPJKlasqkB/Q7KXl3PWjiP3yLXC3tmyvbpYNIBl
        BKpoFpkJheHi6eHk8/A5KbUpNTsWzRyMFv9rFa8Mo7or4DMmNOKKEaPVZLNvQu4oQYwr5v
        n2CB9EiqHS+shvny1JJ/+nBFr0CGVYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-4Jz9VwXbMRuXJnPWmVjOrQ-1; Mon, 20 Jan 2020 08:16:58 -0500
X-MC-Unique: 4Jz9VwXbMRuXJnPWmVjOrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44390107ACC7;
        Mon, 20 Jan 2020 13:16:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-99.ams2.redhat.com [10.36.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CE03858BE;
        Mon, 20 Jan 2020 13:16:53 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v3 4/9] s390x: smp: Rework cpu start and
 active tracking
To:     David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        cohuck@redhat.com
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-5-frankja@linux.ibm.com>
 <0f9984f0-9768-dba8-5e36-8e667bc05c88@redhat.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a370742d-8018-4a21-468a-4d35ab21db58@redhat.com>
Date:   Mon, 20 Jan 2020 14:16:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0f9984f0-9768-dba8-5e36-8e667bc05c88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20/01/2020 13.06, David Hildenbrand wrote:
> On 17.01.20 11:46, Janosch Frank wrote:
[...]
>> +
>> +	if (!cpu)
>> +		return -1;
> 
> -EINVAL?

-ENOERRNOHEADERINKVMUNITTESTS ;-)

 Thomas

