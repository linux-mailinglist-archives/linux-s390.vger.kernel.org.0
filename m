Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1219F8E5
	for <lists+linux-s390@lfdr.de>; Mon,  6 Apr 2020 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgDFPch (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Apr 2020 11:32:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42358 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgDFPcg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 11:32:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id g6so68362pgs.9
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7VmKlpRwdchNnRw95jny/lwjYGByipa2aNaHLJyO/h8=;
        b=fSwjA78fiVaYhEdu9cm73uYz/GAccmeCiK1ZZF4g8pB784H2TQnUZMAM8MtjfAJMyO
         d9nJwtpKzHyK/XvD/i+d7ASW3J9bb4c7iQX9qg/LLhrQETL/w11itQZOIeszuwZg5Jjo
         RJBvnVHRsjFxp7Z/Ert7W22fPXChXSFDFF6hZlbXucc0hlr1ICiSYYdgdhzsco7b8pG+
         Awuzv4X/uWaOAWweNwJbEay4bCblOlH2L3I5sUGoYCUZGTY52UF03KCPX4ZoJPHLHZqn
         vSNV4ygEdkOYPQj6l36AWDRCY1kFnk/Xug2noBWkjc/uqNtPB2QnFnegINZXsUjA6CpE
         Gwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7VmKlpRwdchNnRw95jny/lwjYGByipa2aNaHLJyO/h8=;
        b=qllXf240zMR8hxywdKAChgrzdCGmKAT9UabY0WX1wb30WC4xKKMlemFsMtriVeHdgW
         UqI6hxYy9JhwTNlbYblxaQZxF5GjhwJeRfKMLqI55FRbkrUxYl7x2RG7wXIshp3TQFgP
         n3Q4B4QRgwYwzrXxP9KPYcuPavt5LqiHM7Gz5HX+cdJYLXxxM/zB1NPKkNUWh62td9s1
         uj5I+ELHd+aa61o8cs8BsAXVZyC6PawdMNvs0B3o5EYv8+WCRBjqFIKAqJAQcJnusJ7j
         PMWvwGUzcmgPXlQP0CWntVNJkHE09zUxgXPZu+vsNMi9TRLTgn/1y9QDnroRa0gkpeT4
         Kefw==
X-Gm-Message-State: AGi0PuZ6uDDrOcQQqJ4JCiMPvOybGX6Vugzopd1N+EWAT7OinlOH6NRh
        VCsFr1SX5ZnnY4QnaLUFLkriyg==
X-Google-Smtp-Source: APiQypJ8XlUqjCjeOBH/m7/pYNHylMk/OkqjgnSy2HPHGdoWE0S3xKIKTwqJVb4auTupdnpPuda+rA==
X-Received: by 2002:aa7:99c8:: with SMTP id v8mr23502pfi.151.1586187154140;
        Mon, 06 Apr 2020 08:32:34 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b100:a89e:176d:c04d? ([2605:e000:100e:8c61:b100:a89e:176d:c04d])
        by smtp.gmail.com with ESMTPSA id v42sm11233988pgn.6.2020.04.06.08.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:32:33 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390: Cleanup removed IOSCHED_DEADLINE
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200406074118.86849-1-sth@linux.ibm.com>
 <20200406074118.86849-2-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0efad2a5-90f5-8ccf-169e-9715a64a4bb0@kernel.dk>
Date:   Mon, 6 Apr 2020 08:32:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406074118.86849-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/6/20 1:41 AM, Stefan Haberland wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
> remove legacy IO schedulers").

Isn't this a leftover thing from when dasd selected deadline
internally? I don't think we need this anymore, just kill the
select completely.

-- 
Jens Axboe

